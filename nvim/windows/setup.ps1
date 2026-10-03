#requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string] $Root = (Join-Path $env:LOCALAPPDATA 'DotFiles/nvim'),
    [switch] $PrepareOnly,
    [string] $NeovimPath,
    [string] $ConfigPath = (Join-Path $env:LOCALAPPDATA 'nvim'),
    [string] $DataPath = (Join-Path $env:LOCALAPPDATA 'nvim-data'),
    [string] $BackupRoot = (Join-Path $env:LOCALAPPDATA 'DotFiles/backups/nvim'),
    [switch] $AddToPath,
    [switch] $InstallVCRuntime,
    [switch] $Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$utf8 = New-Object Text.UTF8Encoding($false)
$repo = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
if (-not [IO.Path]::IsPathRooted($Root)) { $Root = Join-Path $PWD.ProviderPath $Root }
$Root = [IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
$manifestPath = Join-Path $PSScriptRoot 'runtime-lock.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
$sourceConfig = Join-Path $PSScriptRoot 'config'

function Test-Beneath([string] $Path, [string] $Parent) {
    return $Path.StartsWith($Parent.TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)
}

function Assert-PlainPath([string] $Path) {
    $cursor = [IO.Path]::GetFullPath($Path)
    while ($cursor) {
        if (Test-Path -LiteralPath $cursor) {
            $item = Get-Item -LiteralPath $cursor -Force
            if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Reparse points are not supported: $cursor" }
        }
        $parent = [IO.Path]::GetDirectoryName($cursor)
        if ($parent -eq $cursor) { break }
        $cursor = $parent
    }
}

function Assert-PlainTree([string] $Path) {
    Assert-PlainPath $Path
    $pending = New-Object 'Collections.Generic.Queue[string]'
    $pending.Enqueue($Path)
    while ($pending.Count -gt 0) {
        foreach ($item in Get-ChildItem -LiteralPath $pending.Dequeue() -Force) {
            if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Reparse points are not supported: $($item.FullName)" }
            if ($item.PSIsContainer) { $pending.Enqueue($item.FullName) }
        }
    }
}

function Get-BundleFiles([string] $Release) {
    foreach ($folder in @('runtime','config','data')) {
        foreach ($file in Get-ChildItem -LiteralPath (Join-Path $Release $folder) -Recurse -File -Force | Sort-Object FullName) {
            $relative = $file.FullName.Substring($Release.Length + 1).Replace('\', '/')
            if ($relative -match '(^|/)\.git(/|$)|(^|/)doc/tags$' -or
                $relative -match '^data/nvim-data/((log|nvim\.log|lsp\.log|lazy-state\.json)$|(shada|swap|undo|backup|view|logs|state|cache)/)') { continue }
            [pscustomobject]@{ path=$relative; sha256=(Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash }
        }
    }
}

function Assert-BundleFiles([string] $Release) {
    Assert-PlainTree $Release
    $bundle = Get-Content -LiteralPath (Join-Path $Release 'bundle.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($bundle.schema_version -ne 1 -or -not $bundle.files) { throw 'Invalid cached bundle manifest.' }
    $actual = @(Get-BundleFiles $Release)
    if ($actual.Count -ne @($bundle.files).Count) { throw 'Cached bundle files changed. Prepare into a new root or inspect the existing release.' }
    $expected = @{}
    foreach ($file in $bundle.files) {
        if ($expected.ContainsKey($file.path)) { throw 'Duplicate cached bundle path.' }
        $expected[$file.path] = $file.sha256
    }
    foreach ($file in $actual) {
        if (-not $expected.ContainsKey($file.path) -or $file.sha256 -ne $expected[$file.path]) { throw "Cached bundle was modified: $($file.path)" }
    }
}

function New-Directory([string] $Path) {
    if (-not (Test-Beneath ([IO.Path]::GetFullPath($Path)) $Root) -and $Path -ne $Root) { throw "Path leaves setup root: $Path" }
    Assert-PlainPath $Path
    [IO.Directory]::CreateDirectory($Path) | Out-Null
}

function Write-Json([string] $Path, $Value) {
    [IO.File]::WriteAllText($Path, ($Value | ConvertTo-Json -Depth 8) + "`n", $utf8)
}

function Get-Archive([string] $Name) {
    $spec = $manifest.downloads.$Name
    if ($spec.sha256 -notmatch '^[a-fA-F0-9]{64}$' -or $spec.url -notmatch '^https://') { throw "Invalid download lock: $Name" }
    $filename = [IO.Path]::GetFileName(([uri] $spec.url).AbsolutePath)
    $archive = Join-Path $Root ('downloads/' + $spec.sha256.Substring(0, 12) + '-' + $filename)
    Assert-PlainPath $archive
    if (-not (Test-Path -LiteralPath $archive)) {
        Write-Host "Downloading $Name $($spec.version)..."
        $partial = $archive + '.part-' + [guid]::NewGuid().ToString('N')
        Invoke-WebRequest -UseBasicParsing -Uri $spec.url -OutFile $partial
        if ((Get-FileHash -LiteralPath $partial -Algorithm SHA256).Hash -ne $spec.sha256) { throw "SHA256 mismatch for $Name. Untrusted download retained at $partial" }
        Move-Item -LiteralPath $partial -Destination $archive
    }
    if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ne $spec.sha256) { throw "Cached archive checksum mismatch: $archive" }
    return $archive
}

function Get-VCRuntime {
    $registry = $null
    $key = $null
    $installed = $false
    $version = ''
    try {
        $registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64)
        $key = $registry.OpenSubKey('SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64')
        if ($key) {
            $installed = $key.GetValue('Installed', 0) -eq 1
            $version = [string] $key.GetValue('Version', '')
        }
    } finally {
        if ($key) { $key.Dispose() }
        if ($registry) { $registry.Dispose() }
    }
    $systemDirectory = 'System32'
    if (-not [Environment]::Is64BitProcess) { $systemDirectory = 'Sysnative' }
    $dll = Join-Path $env:WINDIR ($systemDirectory + '/vcruntime140.dll')
    [pscustomobject]@{ Available = ($installed -and (Test-Path -LiteralPath $dll -PathType Leaf)); Version = $version }
}

function Ensure-VCRuntime([switch] $Install) {
    $runtime = Get-VCRuntime
    if ($runtime.Available) {
        Write-Host "Using installed Microsoft VC++ x64 runtime $($runtime.Version). Compatibility is checked by Neovim integration tests."
        return
    }
    if (-not $Install) {
        throw 'Microsoft VC++ x64 runtime is missing or incomplete. Rerun setup.ps1 with -InstallVCRuntime to install the pinned Microsoft prerequisite with administrator approval.'
    }
    $installedVersion = $null
    if ([version]::TryParse($runtime.Version.TrimStart('v'), [ref] $installedVersion) -and
        $installedVersion -gt [version] $manifest.downloads.vcredist.version) {
        throw 'A newer Microsoft VC++ runtime is registered but incomplete. Repair that runtime; this bootstrap will not downgrade it.'
    }
    New-Directory $Root
    New-Directory (Join-Path $Root 'downloads')
    $installer = Get-Archive 'vcredist'
    $signature = Get-AuthenticodeSignature -LiteralPath $installer
    if ($signature.Status -ne 'Valid' -or $null -eq $signature.SignerCertificate -or
        $signature.SignerCertificate.Subject -notmatch '(^|,\s*)O=Microsoft Corporation(,|$)') {
        throw 'The VC++ runtime installer must have a valid Microsoft Authenticode signature.'
    }
    $log = Join-Path $Root ('downloads/vcredist-' + [guid]::NewGuid().ToString('N') + '.log')
    Write-Host 'Installing the Microsoft VC++ x64 runtime. Windows may ask for administrator approval.'
    $process = Start-Process -FilePath $installer -ArgumentList @('/install', '/passive', '/norestart', '/log', ('"' + $log + '"')) -Verb RunAs -WindowStyle Hidden -Wait -PassThru
    if ($process.ExitCode -eq 3010) {
        throw "The VC++ runtime was installed and requires a Windows restart. Restart manually, then rerun setup; the Neovim profile has not been changed. Log: $log"
    }
    if ($process.ExitCode -ne 0) { throw "VC++ runtime installation failed ($($process.ExitCode)). The Neovim profile has not been changed. Log: $log" }
    if (-not (Get-VCRuntime).Available) { throw "The VC++ runtime is still unavailable after installation. The Neovim profile has not been changed. Log: $log" }
}

function Assert-LauncherTarget([string] $Path) {
    Assert-PlainPath $Path
    $parent = [IO.Path]::GetDirectoryName($Path)
    if ((Test-Path -LiteralPath $parent) -and -not (Test-Path -LiteralPath $parent -PathType Container)) {
        throw "The launcher parent is not a directory: $parent"
    }
    if (Test-Path -LiteralPath $Path -PathType Container) { throw "The launcher destination is a directory: $Path" }
    if (Test-Path -LiteralPath $Path -PathType Leaf) {
        try {
            $probe = [IO.File]::Open($Path, [IO.FileMode]::Open, [IO.FileAccess]::ReadWrite, [IO.FileShare]::None)
            $probe.Dispose()
        } catch { throw "The launcher is not exclusively writable: $Path. $($_.Exception.Message)" }
    }
}

function New-LauncherCandidate([string] $ReleaseId) {
    if ($ReleaseId -notmatch '^[a-f0-9]{16}$') { throw 'Invalid launcher release identifier.' }
    $directory = Join-Path $Root 'bin'
    $target = Join-Path $directory 'nvim.cmd'
    Assert-LauncherTarget $target
    New-Directory $directory
    $candidate = Join-Path $directory ('.nvim-' + [guid]::NewGuid().ToString('N') + '.cmd')
    $content = '@echo off' + "`r`n" + '"%~dp0..\releases\' + $ReleaseId + '\runtime\bin\nvim.exe" %*' + "`r`n"
    [IO.File]::WriteAllText($candidate, $content, [Text.Encoding]::ASCII)
    [pscustomobject]@{ Path = $target; Candidate = $candidate }
}

function Publish-Launcher($Plan) {
    Assert-LauncherTarget $Plan.Path
    Assert-PlainPath $Plan.Candidate
    if (Test-Path -LiteralPath $Plan.Path -PathType Leaf) { [IO.File]::Replace($Plan.Candidate, $Plan.Path, [NullString]::Value) }
    else { [IO.File]::Move($Plan.Candidate, $Plan.Path) }
}

function Expand-SafeZip([string] $Archive, [string] $Destination) {
    New-Directory $Destination
    $zip = [IO.Compression.ZipFile]::OpenRead($Archive)
    try {
        foreach ($entry in $zip.Entries) {
            $target = [IO.Path]::GetFullPath((Join-Path $Destination $entry.FullName))
            if (-not (Test-Beneath $target $Destination)) { throw "Archive entry leaves destination: $($entry.FullName)" }
            if ((($entry.ExternalAttributes -shr 16) -band 0xF000) -eq 0xA000) { throw 'Archive symlinks are not supported.' }
        }
    } finally { $zip.Dispose() }
    [IO.Compression.ZipFile]::ExtractToDirectory($Archive, $Destination)
}

function Move-InRoot([string] $Source, [string] $Destination) {
    foreach ($path in @($Source, $Destination)) {
        if (-not (Test-Beneath ([IO.Path]::GetFullPath($path)) $Root)) { throw "Move leaves setup root: $path" }
        Assert-PlainPath $path
    }
    Move-Item -LiteralPath $Source -Destination $Destination
}

function Invoke-Native([string] $Exe, [string[]] $Arguments) {
    & $Exe @Arguments
    if ($LASTEXITCODE -ne 0) { throw "Command failed ($LASTEXITCODE): $Exe $($Arguments -join ' ')" }
}

function Invoke-EditorCheck([string] $Exe, [string[]] $Arguments) {
    $info = New-Object Diagnostics.ProcessStartInfo
    $info.FileName = $Exe
    $info.Arguments = ($Arguments | ForEach-Object {
        $value = [regex]::Replace($_, '(\\*)"', '$1$1\"')
        $value = [regex]::Replace($value, '(\\+)$', '$1$1')
        '"' + $value + '"'
    }) -join ' '
    $info.UseShellExecute = $false
    $info.CreateNoWindow = $true
    $info.RedirectStandardOutput = $true
    $info.RedirectStandardError = $true
    $process = New-Object Diagnostics.Process
    $process.StartInfo = $info
    try {
        [void] $process.Start()
        $stdout = $process.StandardOutput.ReadToEndAsync()
        $stderr = $process.StandardError.ReadToEndAsync()
        $deadline = [DateTime]::UtcNow.AddSeconds(300)
        while (-not $process.WaitForExit(1000)) {
            if ([DateTime]::UtcNow -gt $deadline) { $process.Kill(); throw 'Neovim integration check timed out after 300 seconds.' }
        }
        $output = $stdout.GetAwaiter().GetResult() + $stderr.GetAwaiter().GetResult()
        Write-Host $output
        if ($process.ExitCode -ne 0) { throw "Neovim integration check failed ($($process.ExitCode))." }
    } finally { $process.Dispose() }
}

function Install-Binary([string] $Name, [string] $Executable, [string] $Stage, [string] $Bin) {
    $unpack = Join-Path $Stage ('unpack/' + $Name)
    Expand-SafeZip (Get-Archive $Name) $unpack
    $matches = @(Get-ChildItem -LiteralPath $unpack -Recurse -File -Filter $Executable)
    if ($matches.Count -ne 1) { throw "Expected exactly one $Executable in $Name archive." }
    Copy-Item -LiteralPath $matches[0].FullName -Destination (Join-Path $Bin $Executable)
}

function Invoke-ProfileCheck([string] $Executable, [string] $Release, [string] $TestName) {
    $env:NVIM_APPNAME = 'nvim'
    $env:XDG_CONFIG_HOME = Join-Path $Release 'config'
    $env:XDG_DATA_HOME = Join-Path $Release 'data'
    $env:XDG_STATE_HOME = $env:XDG_DATA_HOME
    $env:XDG_CACHE_HOME = Join-Path $Release 'cache'
    $env:NVIM_LOG_FILE = $null
    New-Directory (Join-Path $Release 'cache')
    $env:DOTFILES_NVIM_TOOLS = Join-Path $Release 'data/nvim-data/tools'
    $env:GOROOT = Join-Path $env:DOTFILES_NVIM_TOOLS 'go'
    $env:GOBIN = Join-Path $env:DOTFILES_NVIM_TOOLS 'bin'
    $env:GOENV = 'off'
    $env:GOTOOLCHAIN = 'local'
    $env:GOWORK = 'off'
    $env:GOFLAGS = ''
    $env:GOTELEMETRY = 'off'
    $env:GOPATH = Join-Path $Root 'cache/gopath'
    $env:GOCACHE = Join-Path $Root 'cache/go-build'
    $env:GOMODCACHE = Join-Path $Root 'cache/go-mod'
    $env:GOPROXY = 'off'
    $env:DOTFILES_NVIM_TEST = Join-Path $repo ('tests/nvim/' + $TestName + '.lua')
    $env:DOTFILES_NVIM_EXPECT_CONFIG = Join-Path $Release 'config/nvim'
    $env:DOTFILES_NVIM_EXPECT_DATA = Join-Path $Release 'data/nvim-data'
    $env:DOTFILES_NVIM_RUNNER = Join-Path $repo 'tests/nvim/runner.lua'
    $check = 'lua dofile(vim.env.DOTFILES_NVIM_RUNNER)'
    Invoke-EditorCheck $Executable @('--headless', '-i', 'NONE', '-n', '-c', $check)
}

if ($env:OS -ne 'Windows_NT' -or -not [Environment]::Is64BitOperatingSystem -or $env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
    throw 'This bootstrap currently supports Windows x64 only.'
}
if ($manifest.schema -ne 1 -or $manifest.architecture -ne 'x64') { throw 'Unsupported runtime lockfile.' }
foreach ($plugin in $manifest.plugins.PSObject.Properties) {
    if ($plugin.Name -notmatch '^[a-zA-Z0-9][a-zA-Z0-9_.-]+$' -or
        $plugin.Value.repo -notmatch '^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+$' -or
        $plugin.Value.commit -notmatch '^[a-fA-F0-9]{40}$') { throw 'Invalid plugin entry in runtime-lock.json.' }
}
Assert-PlainPath $Root
Assert-PlainTree $sourceConfig
foreach ($protected in @($env:USERPROFILE, $env:LOCALAPPDATA, $env:WINDIR, $env:ProgramFiles, $repo)) {
    if ($protected -and ($Root -eq $protected -or (Test-Beneath $protected $Root))) { throw "Setup root contains a protected directory: $Root" }
}
foreach ($target in @($ConfigPath, $DataPath, $BackupRoot)) {
    $full = [IO.Path]::GetFullPath($target)
    if ($Root -eq $full -or (Test-Beneath $Root $full) -or (Test-Beneath $full $Root)) { throw 'Setup, config, data and backup roots must not overlap.' }
}
if ($PrepareOnly -and $AddToPath) { throw '-AddToPath cannot be combined with -PrepareOnly.' }
if (-not $PrepareOnly -and (([IO.Path]::GetFullPath($ConfigPath) -ne (Join-Path $env:LOCALAPPDATA 'nvim')) -or
    ([IO.Path]::GetFullPath($DataPath) -ne (Join-Path $env:LOCALAPPDATA 'nvim-data')))) {
    throw 'setup.ps1 installs the default Windows profile. Use -PrepareOnly then install.ps1 for custom target paths.'
}
if ($AddToPath -and $NeovimPath) { throw 'Manage PATH through the existing Neovim installation when using -NeovimPath.' }
if ($AddToPath) {
    $existing = Get-Command nvim -ErrorAction SilentlyContinue
    if ($existing -and $existing.Source -and -not (Test-Beneath $existing.Source $Root)) {
        throw "Another Neovim is on PATH: $($existing.Source). Use -NeovimPath, or remove that installation before adding this one."
    }
}
if (-not $PSCmdlet.ShouldProcess($Root, 'Download pinned tools, prepare and test a Windows Neovim profile')) { return }

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName System.IO.Compression.FileSystem
$savedEnv = @{}
$environmentNames = @('PATH','NVIM_APPNAME','XDG_CONFIG_HOME','XDG_DATA_HOME','XDG_STATE_HOME','XDG_CACHE_HOME','NVIM_LOG_FILE','DOTFILES_NVIM_TOOLS','DOTFILES_NVIM_TEST','DOTFILES_NVIM_RUNNER','DOTFILES_NVIM_EXPECT_CONFIG','DOTFILES_NVIM_EXPECT_DATA','GOPATH','GOBIN','GOCACHE','GOMODCACHE','GOENV','GOTOOLCHAIN','GOPROXY','GOSUMDB','GOPRIVATE','GONOSUMDB','GOROOT','GOWORK','GOFLAGS','GOTELEMETRY','CGO_ENABLED','npm_config_cache')
foreach ($name in $environmentNames) { $savedEnv[$name] = [Environment]::GetEnvironmentVariable($name, 'Process') }
try {
    if (-not $PrepareOnly -and -not $NeovimPath) { Assert-LauncherTarget (Join-Path $Root 'bin/nvim.cmd') }
    Ensure-VCRuntime -Install:$InstallVCRuntime
    New-Directory $Root
    foreach ($path in @('downloads','cache','releases')) { New-Directory (Join-Path $Root $path) }
    Assert-PlainTree (Join-Path $Root 'cache')
    $fingerprintFiles = @($manifestPath, (Join-Path $PSScriptRoot 'tools/package-lock.json'), (Join-Path $PSScriptRoot 'tools/package.json'), $PSCommandPath)
    $fingerprintFiles += @(Get-ChildItem -LiteralPath $sourceConfig -Recurse -File | Sort-Object FullName | ForEach-Object { $_.FullName })
    $fingerprintFiles += @(Get-ChildItem -LiteralPath (Join-Path $repo 'tests/nvim') -File | Sort-Object FullName | ForEach-Object { $_.FullName })
    $hashes = ($fingerprintFiles | ForEach-Object { $_.Substring($repo.Length) + ':' + (Get-FileHash -LiteralPath $_ -Algorithm SHA256).Hash }) -join "`n"
    $sha = [Security.Cryptography.SHA256]::Create()
    try { $releaseId = ([BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($hashes)))).Replace('-', '').Substring(0, 16).ToLowerInvariant() }
    finally { $sha.Dispose() }
    $release = Join-Path $Root ('releases/' + $releaseId)
    Assert-PlainPath $release
    if (-not (Test-Path -LiteralPath (Join-Path $release 'bundle.json'))) {
        if (Test-Path -LiteralPath $release) { throw "Incomplete release exists: $release. Inspect it before preparing again." }
        $stage = Join-Path $Root ('releases/.stage-' + [guid]::NewGuid().ToString('N'))
        foreach ($path in @('config/nvim','data/nvim-data/tools/bin','data/nvim-data/lazy','unpack')) { New-Directory (Join-Path $stage $path) }
        $tools = Join-Path $stage 'data/nvim-data/tools'
        $bin = Join-Path $tools 'bin'
        Expand-SafeZip (Get-Archive 'neovim') (Join-Path $stage 'unpack/neovim')
        Move-InRoot (Join-Path $stage 'unpack/neovim/nvim-win64') (Join-Path $stage 'runtime')
        Expand-SafeZip (Get-Archive 'git') (Join-Path $tools 'git')
        Expand-SafeZip (Get-Archive 'go') (Join-Path $stage 'unpack/go')
        Move-InRoot (Join-Path $stage 'unpack/go/go') (Join-Path $tools 'go')
        Expand-SafeZip (Get-Archive 'node') (Join-Path $stage 'unpack/node')
        Move-InRoot (Join-Path $stage ('unpack/node/node-' + $manifest.downloads.node.version + '-win-x64')) (Join-Path $tools 'node')
        Install-Binary 'ruff' 'ruff.exe' $stage $bin
        Install-Binary 'taplo' 'taplo.exe' $stage $bin
        Install-Binary 'ripgrep' 'rg.exe' $stage $bin
        $env:PATH = (Join-Path $tools 'node') + ';' + (Join-Path $tools 'go/bin') + ';' + (Join-Path $tools 'git/cmd') + ';' + $bin + ';' + $savedEnv.PATH
        $env:GOENV = 'off'
        $env:GOTOOLCHAIN = 'local'
        $env:GOWORK = 'off'
        $env:GOFLAGS = ''
        $env:GOTELEMETRY = 'off'
        $env:CGO_ENABLED = '0'
        $env:GOROOT = Join-Path $tools 'go'
        $env:GOPATH = Join-Path $Root 'cache/gopath'
        $env:GOCACHE = Join-Path $Root 'cache/go-build'
        $env:GOMODCACHE = Join-Path $Root 'cache/go-mod'
        $env:GOBIN = $bin
        $env:GOPROXY = 'https://proxy.golang.org'
        $env:GOSUMDB = 'sum.golang.org'
        $env:GOPRIVATE = ''
        $env:GONOSUMDB = ''
        Write-Host "Building gopls $($manifest.gopls.version)..."
        Invoke-Native (Join-Path $tools 'go/bin/go.exe') @('install', ($manifest.gopls.module + '@' + $manifest.gopls.version))
        New-Directory (Join-Path $tools 'npm')
        foreach ($name in @('package.json','package-lock.json')) { Copy-Item -LiteralPath (Join-Path $PSScriptRoot ('tools/' + $name)) -Destination (Join-Path $tools ('npm/' + $name)) }
        Invoke-Native (Join-Path $tools 'node/node.exe') @((Join-Path $tools 'node/node_modules/npm/bin/npm-cli.js'),'ci','--prefix',(Join-Path $tools 'npm'),'--ignore-scripts','--no-audit','--no-fund','--cache',(Join-Path $Root 'cache/npm'))
        $git = Join-Path $tools 'git/cmd/git.exe'
        foreach ($plugin in $manifest.plugins.PSObject.Properties) {
            $destination = Join-Path $stage ('data/nvim-data/lazy/' + $plugin.Name)
            Write-Host "Installing $($plugin.Name)..."
            Invoke-Native $git @('init','--quiet',$destination)
            Invoke-Native $git @('-C',$destination,'config','core.longpaths','true')
            Invoke-Native $git @('-C',$destination,'config','core.sparseCheckout','true')
            [IO.File]::WriteAllText((Join-Path $destination '.git/info/sparse-checkout'), "/*`n!/tests/`n!/.github/`n", $utf8)
            Invoke-Native $git @('-C',$destination,'remote','add','origin',('https://github.com/' + $plugin.Value.repo + '.git'))
            Invoke-Native $git @('-C',$destination,'-c','core.autocrlf=false','fetch','--quiet','--depth=1','origin',$plugin.Value.commit)
            Invoke-Native $git @('-C',$destination,'-c','core.autocrlf=false','checkout','--quiet','--detach','FETCH_HEAD')
            $actual = & $git -C $destination rev-parse HEAD
            if ($LASTEXITCODE -ne 0 -or $actual -ne $plugin.Value.commit) { throw "Plugin revision mismatch: $($plugin.Name)" }
        }
        Get-ChildItem -LiteralPath $sourceConfig -Force | Copy-Item -Destination (Join-Path $stage 'config/nvim') -Recurse
        $descriptor = [ordered]@{
            schema_version = 1
            nvim_version = $manifest.downloads.neovim.version
            runtime_lock_sha256 = (Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256).Hash
            plugin_lock_sha256 = (Get-FileHash -LiteralPath (Join-Path $sourceConfig 'lazy-lock.json') -Algorithm SHA256).Hash
            required_files = @('lazy/lazy.nvim/lua/lazy/init.lua','tools/bin/ruff.exe','tools/bin/gopls.exe','tools/bin/taplo.exe','tools/bin/rg.exe','tools/node/node.exe','tools/go/bin/go.exe','tools/git/cmd/git.exe','tools/npm/node_modules/yaml-language-server/bin/yaml-language-server','tools/npm/node_modules/markdownlint-cli2/markdownlint-cli2-bin.mjs','tools/npm/node_modules/pyright/langserver.index.js')
        }
        Write-Json (Join-Path $stage 'data/nvim-data/dotfiles-runtime.json') $descriptor
        Write-Json (Join-Path $stage 'bundle.json') ([ordered]@{ schema_version=1; release=$releaseId; files=@(Get-BundleFiles $stage) })
        Move-InRoot $stage $release
    }
    Assert-BundleFiles $release
    $exe = Join-Path $release 'runtime/bin/nvim.exe'
    if ($NeovimPath) { $exe = (Get-Command $NeovimPath -ErrorAction Stop).Source }
    Write-Host 'Checking the isolated profile and language diagnostics...'
    Invoke-ProfileCheck $exe $release 'smoke'
    Invoke-ProfileCheck $exe $release 'languages'
    Write-Json (Join-Path $release 'prepared.json') ([ordered]@{ schema_version=1; release=$releaseId; nvim=$manifest.downloads.neovim.version })
    $result = [pscustomobject]@{ Root=$Root; Release=$release; NeovimPath=$exe; ConfigPath=(Join-Path $release 'config/nvim'); DataPath=(Join-Path $release 'data/nvim-data') }
    if (-not $PrepareOnly) {
        $launcherPlan = $null
        try {
            if (-not $NeovimPath) { $launcherPlan = New-LauncherCandidate $releaseId }
            & (Join-Path $PSScriptRoot 'install.ps1') -SourcePath $result.ConfigPath -PreparedDataPath $result.DataPath -ConfigPath $ConfigPath -DataPath $DataPath -BackupRoot $BackupRoot -Force:$Force
            try {
                if ($launcherPlan) { Publish-Launcher $launcherPlan }
                if ($AddToPath) {
                    $launchDir = Join-Path $Root 'bin'
                    $userPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
                    if (($userPath -split ';') -notcontains $launchDir) { [Environment]::SetEnvironmentVariable('PATH', ($launchDir + ';' + $userPath), 'User') }
                    Write-Host 'Open a new terminal to use the updated user PATH.'
                }
            } catch { throw "Profile installed, launcher/PATH failed; backup already printed for a changed profile. $($_.Exception.Message)" }
        } finally {
            if ($launcherPlan -and (Test-Path -LiteralPath $launcherPlan.Candidate)) {
                Assert-PlainPath $launcherPlan.Candidate
                [IO.File]::Delete($launcherPlan.Candidate)
            }
        }
    }
    $result
} finally {
    foreach ($name in $environmentNames) { [Environment]::SetEnvironmentVariable($name, $savedEnv[$name], 'Process') }
}
