[CmdletBinding()]
param(
    [switch]$Staged,
    [string]$NvimPath = 'nvim',
    [string]$Repository,
    [string]$CommitMessageFile
)

$ErrorActionPreference = 'Stop'
if (-not $Repository) { $Repository = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..')) }
$utf8 = New-Object System.Text.UTF8Encoding($false, $true)
$script:issues = New-Object 'System.Collections.Generic.List[string]'
$temporaryRoot = $null

function ConvertTo-NativeArgument([string]$Value) {
    $quoted = [regex]::Replace($Value, '(\\*)"', '$1$1\"')
    $quoted = [regex]::Replace($quoted, '(\\+)$', '$1$1')
    return '"' + $quoted + '"'
}

function Invoke-ProcessBytes([string]$Executable, [string[]]$Arguments, [hashtable]$Environment = @{}) {
    $info = New-Object System.Diagnostics.ProcessStartInfo
    $info.FileName = $Executable
    $info.Arguments = (($Arguments | ForEach-Object { ConvertTo-NativeArgument $_ }) -join ' ')
    $info.UseShellExecute = $false
    $info.CreateNoWindow = $true
    $info.RedirectStandardOutput = $true
    $info.RedirectStandardError = $true
    foreach ($key in $Environment.Keys) { $info.EnvironmentVariables[$key] = $Environment[$key] }
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $info
    $memory = New-Object System.IO.MemoryStream
    try {
        [void]$process.Start()
        $errorTask = $process.StandardError.ReadToEndAsync()
        $process.StandardOutput.BaseStream.CopyTo($memory)
        $process.WaitForExit()
        $errorText = $errorTask.GetAwaiter().GetResult()
        if ($process.ExitCode -ne 0) {
            throw "$Executable failed ($($process.ExitCode)): $errorText"
        }
        return ,$memory.ToArray()
    }
    finally { $process.Dispose(); $memory.Dispose() }
}

function Invoke-GitBytes([string[]]$Arguments) {
    return ,(Invoke-ProcessBytes 'git' (@('-C', $Repository) + $Arguments))
}

function Test-CommitMessage([string]$Path) {
    $message = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath $Path).Path, $utf8)
    $header = ($message -split '\r?\n', 2)[0]
    if ($header.Length -gt 72) { $script:issues.Add('Commit header must be at most 72 characters.') }
    if ($header -match '[^\x20-\x7e]') { $script:issues.Add('Commit header must use printable ASCII; write it in English.') }
    if ($header -notmatch '^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\([a-z0-9][a-z0-9/-]*\))?!?: [a-z][^\r\n]+$') {
        $script:issues.Add('Use type(scope): concise imperative summary; scope is optional.')
    }
    if ($message -match '(?im)^Co-Authored-By:.*(?:codex|openai|claude|anthropic|copilot|chatgpt|cursor|gemini)' -or
        $message -match '(?im)^.*generated (?:by|with)\s+(?:AI|codex|openai|claude|copilot|chatgpt|cursor|gemini)\b') {
        $script:issues.Add('Remove generated attribution and assistant trailers from the commit message.')
    }
}

function Test-Source([string]$RelativePath, [byte[]]$Bytes, [string]$SnapshotRoot) {
    $extension = [System.IO.Path]::GetExtension($RelativePath).ToLowerInvariant()
    if ($RelativePath -match '(^|/)(AGENTS\.md|\.agents|\.codex)(/|$)' -or
        $RelativePath -match '(^|/)(\.build|__pycache__|\.pytest_cache|\.mypy_cache|\.ruff_cache|node_modules|nvim-data|backups?)(/|$)' -or
        $RelativePath -match '^nvim/(windows/(config/)?)?(\.runtime|\.state|cache|state|data|lazy|shada|swap|site)/' -or
        $RelativePath -match '(^|/)\.nvimlog$' -or
        $RelativePath -match '\.(bak|swp|swo|pyc|pyo|log)$') {
        $script:issues.Add("${RelativePath}: generated or local-only file must not be staged.")
    }
    if ([Array]::IndexOf($Bytes, [byte]0) -ge 0) {
        if ($extension -in @('.lua', '.ps1', '.json', '.md', '.txt', '.yml', '.yaml', '.toml', '.sh', '.pem') -or
            $RelativePath.StartsWith('.githooks/')) {
            $script:issues.Add("${RelativePath}: text source contains NUL bytes; save it as UTF-8.")
        }
        return
    }
    try { $text = $utf8.GetString($Bytes) }
    catch { $script:issues.Add("${RelativePath}: source must be valid UTF-8."); return }
    if ($Bytes.Length -ge 3 -and $Bytes[0] -eq 0xef -and $Bytes[1] -eq 0xbb -and $Bytes[2] -eq 0xbf) {
        $script:issues.Add("${RelativePath}: remove the UTF-8 byte order mark.")
    }
    if ($text -match '(?m)[\t ]+\r?$') { $script:issues.Add("${RelativePath}: trailing whitespace.") }
    if ($text -match '(?m)^(<{7}|={7}|>{7})(?: |\r?$)') { $script:issues.Add("${RelativePath}: unresolved conflict marker.") }
    if ($text -match '(?m)^-----BEGIN (?:RSA |EC |DSA |OPENSSH |ENCRYPTED )?PRIVATE KEY-----') {
        $script:issues.Add("${RelativePath}: private key marker found.")
    }
    if ($text.Length -gt 0 -and -not $text.EndsWith("`n")) { $script:issues.Add("${RelativePath}: add a final newline.") }
    switch ($extension) {
        '.json' {
            try {
                if ([string]::IsNullOrWhiteSpace($text)) { throw 'JSON must contain a value.' }
                if ($PSVersionTable.PSVersion.Major -ge 6) {
                    $null = ConvertFrom-Json -InputObject $text -AsHashtable -ErrorAction Stop
                }
                else {
                    # PS 5.1 PSCustomObject conversion rejects valid empty JSON keys.
                    Add-Type -AssemblyName System.Web.Extensions
                    $parser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
                    $parser.MaxJsonLength = [int]::MaxValue
                    $null = $parser.DeserializeObject($text)
                }
            }
            catch { $script:issues.Add("${RelativePath}: invalid JSON: $($_.Exception.Message)") }
        }
        '.ps1' {
            $tokens = $null
            $parseErrors = $null
            $null = [System.Management.Automation.Language.Parser]::ParseInput($text, [ref]$tokens, [ref]$parseErrors)
            foreach ($parseError in $parseErrors) { $script:issues.Add("${RelativePath}: invalid PowerShell: $($parseError.Message)") }
        }
        '.lua' {
            # Snapshot bytes, not working-tree files, are passed to Neovim.
            $snapshot = Join-Path $SnapshotRoot ($script:luaFiles.Count.ToString() + '.lua')
            [System.IO.File]::WriteAllBytes($snapshot, $Bytes)
            $script:luaFiles.Add($snapshot)
            $script:luaNames[$snapshot] = $RelativePath
        }
    }
}

try {
    if ($CommitMessageFile) {
        if ($Staged) { throw '-Staged and -CommitMessageFile cannot be combined.' }
        Test-CommitMessage $CommitMessageFile
    }
    else {
        $Repository = (Resolve-Path -LiteralPath $Repository).Path
        $rootBytes = Invoke-GitBytes @('rev-parse', '--show-toplevel')
        $Repository = $utf8.GetString($rootBytes).TrimEnd("`r", "`n")
        $temporaryRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('dotfiles-check-' + [guid]::NewGuid().ToString('N'))
        [void][System.IO.Directory]::CreateDirectory($temporaryRoot)
        $script:luaFiles = New-Object 'System.Collections.Generic.List[string]'
        $script:luaNames = @{}
        if ($Staged) {
            $names = $utf8.GetString((Invoke-GitBytes @('diff', '--cached', '--name-only', '--diff-filter=ACMR', '-z'))).Split([char]0)
            $index = @{}
            foreach ($entry in $utf8.GetString((Invoke-GitBytes @('ls-files', '--stage', '-z'))).Split([char]0)) {
                if ($entry -match '^(\d+) ([a-f0-9]+) 0\t([\s\S]+)$') { $index[$Matches[3]] = $Matches[2] }
            }
            foreach ($name in $names) {
                if (-not $name) { continue }
                if (-not $index.ContainsKey($name)) { throw "No stage-zero blob for $name; resolve the index first." }
                Test-Source $name (Invoke-GitBytes @('cat-file', 'blob', $index[$name])) $temporaryRoot
            }
        }
        else {
            $names = $utf8.GetString((Invoke-GitBytes @('ls-files', '--cached', '--others', '--exclude-standard', '-z'))).Split([char]0) | Select-Object -Unique
            foreach ($name in $names) {
                if ($name -notmatch '^(nvim/windows/|scripts/windows/[^/]+\.ps1$|tests/(windows|nvim)/|\.githooks/|\.github/workflows/windows\.yml$|\.gitattributes$|\.gitignore$|(nvim/|scripts/|tests/)?README\.md$)') { continue }
                $source = Join-Path $Repository $name
                if (Test-Path -LiteralPath $source -PathType Leaf) {
                    Test-Source $name ([System.IO.File]::ReadAllBytes($source)) $temporaryRoot
                }
            }
        }
        if ($script:luaFiles.Count -gt 0) {
            $manifest = Join-Path $temporaryRoot 'files.json'
            [System.IO.File]::WriteAllText($manifest, (ConvertTo-Json -InputObject @($script:luaFiles.ToArray())), $utf8)
            $validator = Join-Path $temporaryRoot 'validate.lua'
            $lua = @'
local paths = vim.json.decode(table.concat(vim.fn.readfile(vim.env.DOTFILES_LUA_FILES), "\n"))
local failed = false
for _, path in ipairs(paths) do
  local chunk, err = loadfile(path)
  if not chunk then
    io.stderr:write(err .. "\n")
    failed = true
  end
end
if failed then vim.cmd("cquit 1") end
'@
            [System.IO.File]::WriteAllText($validator, $lua, $utf8)
            try {
                $null = Invoke-ProcessBytes $NvimPath @('--headless', '-u', 'NONE', '-i', 'NONE', '-n', '-c', 'lua dofile(vim.env.DOTFILES_LUA_CHECK)', '-c', 'qa!') @{
                    DOTFILES_LUA_FILES = $manifest
                    DOTFILES_LUA_CHECK = $validator
                }
            }
            catch {
                $description = $_.Exception.Message
                foreach ($snapshot in $script:luaNames.Keys) { $description = $description.Replace($snapshot, $script:luaNames[$snapshot]) }
                $script:issues.Add("Lua syntax check failed: $description")
            }
        }
    }
    if ($script:issues.Count -gt 0) {
        foreach ($issue in $script:issues) { [Console]::Error.WriteLine($issue) }
        exit 1
    }
    Write-Output 'Checks passed.'
}
catch { [Console]::Error.WriteLine($_.Exception.Message); exit 1 }
finally {
    if ($temporaryRoot -and (Test-Path -LiteralPath $temporaryRoot)) {
        $resolvedTemporary = [System.IO.Path]::GetFullPath($temporaryRoot)
        $expectedParent = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\', '/')
        if ([System.IO.Path]::GetDirectoryName($resolvedTemporary) -ne $expectedParent -or
            [System.IO.Path]::GetFileName($resolvedTemporary) -notmatch '^dotfiles-check-[a-f0-9]{32}$') {
            throw 'Refusing to remove an unexpected temporary directory.'
        }
        Remove-Item -LiteralPath $resolvedTemporary -Recurse -Force
    }
}
