#requires -Version 5.1
[CmdletBinding()]
param(
    [string]$PowerShellPath,
    [ValidateRange(1, 60)]
    [int]$TimeoutSeconds = 20
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$repository = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$setupScript = Join-Path $repository 'nvim/windows/setup.ps1'
$buildRoot = Join-Path $repository '.build'
$testRoot = Join-Path $buildRoot ('setup-tests-' + [guid]::NewGuid().ToString('N'))
$utf8 = New-Object Text.UTF8Encoding($false)
$script:passed = 0
$script:caseNumber = 0
if (-not $PowerShellPath) { $PowerShellPath = (Get-Process -Id $PID).Path }

function Assert([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Assert-WithinTests([string]$Path) {
    $full = [IO.Path]::GetFullPath($Path)
    if ($full -ne $testRoot -and -not $full.StartsWith($testRoot + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Test path leaves its temporary root: $full"
    }
    return $full
}

function Write-Text([string]$Path, [string]$Text) {
    $Path = Assert-WithinTests $Path
    [void][IO.Directory]::CreateDirectory((Split-Path -Parent $Path))
    [IO.File]::WriteAllText($Path, $Text, $utf8)
}

function Snapshot([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return '<absent>' }
    $entries = foreach ($item in Get-ChildItem -LiteralPath $Path -Force -Recurse | Sort-Object FullName) {
        Assert (-not ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'Snapshot encountered an unexpected reparse point.'
        $relative = $item.FullName.Substring($Path.Length)
        if ($item.PSIsContainer) { "directory $relative" }
        else { "file $relative $((Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash)" }
    }
    return ($entries -join "`n")
}

function New-Fixture {
    $script:caseNumber++
    $path = Join-Path $testRoot ('case ' + $script:caseNumber)
    [void][IO.Directory]::CreateDirectory($path)
    $fixture = @{
        Path = $path
        Runtime = (Join-Path $path 'runtime')
        LocalAppData = (Join-Path $path 'local app data')
        Location = (Join-Path $path 'PowerShell cwd')
        ProcessDirectory = (Join-Path $path 'process cwd')
        NetworkMarker = (Join-Path $path 'network-attempt.txt')
        Result = (Join-Path $path 'environment.json')
    }
    [void][IO.Directory]::CreateDirectory($fixture.Location)
    [void][IO.Directory]::CreateDirectory($fixture.ProcessDirectory)
    return $fixture
}

function Add-ProfileSentinels([hashtable]$Fixture) {
    Write-Text (Join-Path $Fixture.LocalAppData 'nvim/user.lua') "return 'user configuration'`n"
    Write-Text (Join-Path $Fixture.LocalAppData 'nvim-data/shada/user-state') "Existing user state.`n"
}

function Add-CorruptArchive([string]$Root) {
    $manifest = [IO.File]::ReadAllText((Join-Path $repository 'nvim/windows/runtime-lock.json')) | ConvertFrom-Json
    $spec = $manifest.downloads.neovim
    $filename = [IO.Path]::GetFileName(([uri]$spec.url).AbsolutePath)
    $archive = Join-Path $Root ('downloads/' + $spec.sha256.Substring(0, 12) + '-' + $filename)
    Write-Text $archive "This is deliberately not the locked Neovim archive.`n"
    return $archive
}

function Quote-Argument([string]$Value) {
    $quoted = [regex]::Replace($Value, '(\\*)"', '$1$1\"')
    $quoted = [regex]::Replace($quoted, '(\\+)$', '$1$1')
    return '"' + $quoted + '"'
}

function Invoke-SetupCase([hashtable]$Fixture, [hashtable]$Parameters, [string]$Script = $setupScript, [switch]$ParseOnly, [string]$BundleRoot, [switch]$BundleOrderTest, [string]$RuntimeTest, [string]$LauncherTest) {
    $inputPath = Join-Path $Fixture.Path 'input.json'
    Write-Text $inputPath (([ordered]@{
        Script = $Script
        Parameters = $Parameters
        LocalAppData = $Fixture.LocalAppData
        Location = $Fixture.Location
        NetworkMarker = $Fixture.NetworkMarker
        Result = $Fixture.Result
        ParseOnly = [bool]$ParseOnly
        BundleRoot = $BundleRoot
        BundleOrderTest = [bool]$BundleOrderTest
        RuntimeTest = $RuntimeTest
        LauncherTest = $LauncherTest
        RuntimeRoot = $Fixture.Runtime
    } | ConvertTo-Json -Depth 10) + "`n")
    $info = New-Object Diagnostics.ProcessStartInfo
    $info.FileName = $PowerShellPath
    $arguments = @('-NoProfile', '-NonInteractive', '-ExecutionPolicy', 'Bypass', '-File', (Join-Path $testRoot 'driver.ps1'), '-InputPath', $inputPath)
    $info.Arguments = (($arguments | ForEach-Object { Quote-Argument $_ }) -join ' ')
    $info.WorkingDirectory = $Fixture.ProcessDirectory
    $info.UseShellExecute = $false
    $info.CreateNoWindow = $true
    $info.RedirectStandardOutput = $true
    $info.RedirectStandardError = $true
    $process = New-Object Diagnostics.Process
    $process.StartInfo = $info
    try {
        [void]$process.Start()
        $outTask = $process.StandardOutput.ReadToEndAsync()
        $errTask = $process.StandardError.ReadToEndAsync()
        if (-not $process.WaitForExit($TimeoutSeconds * 1000)) {
            $process.Kill()
            $process.WaitForExit()
            throw "Setup exceeded the $TimeoutSeconds second test timeout."
        }
        $result = @{ Code = $process.ExitCode; Output = $outTask.GetAwaiter().GetResult() + $errTask.GetAwaiter().GetResult() }
    }
    finally { $process.Dispose() }
    Assert (-not (Test-Path -LiteralPath $Fixture.NetworkMarker)) "Setup attempted network access:`n$($result.Output)"
    Assert (Test-Path -LiteralPath $Fixture.Result -PathType Leaf) "The child did not report its environment:`n$($result.Output)"
    $environment = [IO.File]::ReadAllText($Fixture.Result) | ConvertFrom-Json
    Assert $environment.ProcessPathUnchanged 'Setup changed process PATH after returning.'
    Assert $environment.UserPathUnchanged 'Setup changed persistent user PATH.'
    $result.Environment = $environment
    return $result
}

function Assert-Failure([hashtable]$Result, [string]$ExpectedMessage) {
    Assert ($Result.Code -ne 0) "Setup unexpectedly succeeded:`n$($Result.Output)"
    Assert ($Result.Output -match $ExpectedMessage) "Setup failed for an unexpected reason:`n$($Result.Output)"
}

function Test-Case([string]$Name, [scriptblock]$Action) {
    & $Action
    $script:passed++
    Write-Output "PASS $Name"
}

function Copy-SetupFixture([hashtable]$Fixture) {
    $copyRoot = Join-Path $Fixture.Path 'repository copy'
    $copyScript = Join-Path $copyRoot 'nvim/windows/setup.ps1'
    Write-Text $copyScript ([IO.File]::ReadAllText($setupScript))
    Write-Text (Join-Path $copyRoot 'nvim/windows/runtime-lock.json') ([IO.File]::ReadAllText((Join-Path $repository 'nvim/windows/runtime-lock.json')))
    Write-Text (Join-Path $copyRoot 'nvim/windows/config/init.lua') "vim.opt.number = true`n"
    Write-Text (Join-Path $copyRoot 'nvim/windows/config/lazy-lock.json') "{}`n"
    Write-Text (Join-Path $copyRoot 'nvim/windows/tools/package.json') "{}`n"
    Write-Text (Join-Path $copyRoot 'nvim/windows/tools/package-lock.json') "{}`n"
    Write-Text (Join-Path $copyRoot 'tests/nvim/smoke.lua') "return true`n"
    return $copyScript
}

# Never create fixture files through an existing junction in the workspace.
$cursor = $buildRoot
while ($cursor) {
    if (Test-Path -LiteralPath $cursor) {
        Assert (-not ((Get-Item -LiteralPath $cursor -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) 'Test root has a reparse-point ancestor.'
    }
    $cursor = [IO.Path]::GetDirectoryName($cursor)
}

try {
    [void][IO.Directory]::CreateDirectory($testRoot)
    $driver = @'
param([string]$InputPath)
$ErrorActionPreference = 'Stop'
$inputCase = [IO.File]::ReadAllText($InputPath) | ConvertFrom-Json
$env:LOCALAPPDATA = $inputCase.LocalAppData
Set-Location -LiteralPath $inputCase.Location
$processPathBefore = $env:PATH
$userPathBefore = [Environment]::GetEnvironmentVariable('PATH', 'User')
$processDirectory = [Environment]::CurrentDirectory
$failure = $null
$script:mockStarts = 0
$script:signatureChecks = 0
function global:Invoke-WebRequest {
    [IO.File]::WriteAllText($inputCase.NetworkMarker, 'Network access was attempted.')
    throw 'Network access is forbidden in bootstrap tests.'
}
try {
    if ($inputCase.ParseOnly) {
        $tokens = $null
        $errors = $null
        $null = [Management.Automation.Language.Parser]::ParseFile($inputCase.Script, [ref]$tokens, [ref]$errors)
        if ($errors.Count -gt 0) { throw ($errors.Message -join '; ') }
    }
    elseif ($inputCase.RuntimeTest -or $inputCase.LauncherTest) {
        $tokens = $null
        $errors = $null
        $ast = [Management.Automation.Language.Parser]::ParseFile($inputCase.Script, [ref]$tokens, [ref]$errors)
        if ($errors.Count -gt 0) { throw ($errors.Message -join '; ') }
        if ($inputCase.RuntimeTest) {
            $requiredFunctions = @('Test-Beneath', 'Assert-PlainPath', 'New-Directory', 'Get-Archive', 'Ensure-VCRuntime')
        }
        else {
            $requiredFunctions = @('Test-Beneath', 'Assert-PlainPath', 'New-Directory', 'Assert-LauncherTarget', 'New-LauncherCandidate', 'Publish-Launcher')
        }
        $definitions = @($ast.FindAll({
            param($node)
            $node -is [Management.Automation.Language.FunctionDefinitionAst] -and $requiredFunctions -contains $node.Name
        }, $true))
        if ($definitions.Count -ne $requiredFunctions.Count) { throw 'The production prerequisite functions could not be extracted.' }
        foreach ($definition in $definitions) { . ([scriptblock]::Create($definition.Extent.Text)) }
        $Root = $inputCase.RuntimeRoot
        if ($inputCase.RuntimeTest) {
            $script:runtimeCase = $inputCase.RuntimeTest
            $payload = [Text.Encoding]::UTF8.GetBytes('Runtime installer fixture, never execute.')
            $sha = [Security.Cryptography.SHA256]::Create()
            try { $hash = ([BitConverter]::ToString($sha.ComputeHash($payload))).Replace('-', '').ToLowerInvariant() }
            finally { $sha.Dispose() }
            $manifest = [pscustomobject]@{ downloads = [pscustomobject]@{ vcredist = [pscustomobject]@{
                version = '14.51.36247.0'; url = 'https://fixture.invalid/VC_redist.x64.exe'; sha256 = $hash
            } } }
            if ($script:runtimeCase -notin @('present-old', 'present-new', 'missing-no-opt-in', 'newer-incomplete')) {
                $downloads = Join-Path $Root 'downloads'
                [void][IO.Directory]::CreateDirectory($downloads)
                $archive = Join-Path $downloads ($hash.Substring(0, 12) + '-VC_redist.x64.exe')
                if ($script:runtimeCase -eq 'bad-hash') { $payload = [Text.Encoding]::UTF8.GetBytes('Corrupt fixture.') }
                [IO.File]::WriteAllBytes($archive, $payload)
            }
            function Get-VCRuntime {
                if ($script:runtimeCase -eq 'present-old') { return [pscustomobject]@{ Available = $true; Version = 'v14.34.31931.0' } }
                if ($script:runtimeCase -eq 'present-new') { return [pscustomobject]@{ Available = $true; Version = 'v99.0.0.0' } }
                if ($script:runtimeCase -eq 'newer-incomplete') { return [pscustomobject]@{ Available = $false; Version = 'v99.0.0.0' } }
                return [pscustomobject]@{ Available = ($script:mockStarts -gt 0 -and $script:runtimeCase -ne 'not-installed'); Version = '' }
            }
            function Get-AuthenticodeSignature([string]$LiteralPath) {
                $script:signatureChecks++
                $status = 'Valid'
                $subject = 'CN=Microsoft Corporation, O=Microsoft Corporation, C=US'
                if ($script:runtimeCase -eq 'unsigned') { $status = 'NotSigned' }
                if ($script:runtimeCase -eq 'wrong-publisher') { $subject = 'CN=Other Publisher, O=Other Publisher, C=US' }
                return [pscustomobject]@{ Status = $status; SignerCertificate = [pscustomobject]@{ Subject = $subject } }
            }
            function Start-Process([string]$FilePath, [string[]]$ArgumentList, [string]$Verb, [string]$WindowStyle, [switch]$Wait, [switch]$PassThru) {
                $script:mockStarts++
                if ($Verb -ne 'RunAs' -or $WindowStyle -ne 'Hidden' -or -not $Wait -or -not $PassThru -or
                    '/install' -notin $ArgumentList -or '/passive' -notin $ArgumentList -or '/norestart' -notin $ArgumentList) {
                    throw 'The runtime installer options do not preserve elevation and restart handling.'
                }
                if ($script:runtimeCase -eq 'uac-cancelled') { throw 'Administrator approval was cancelled.' }
                $code = 0
                if ($script:runtimeCase -eq 'reboot') { $code = 3010 }
                if ($script:runtimeCase -eq 'failure') { $code = 1603 }
                return [pscustomobject]@{ ExitCode = $code }
            }
            Ensure-VCRuntime -Install:($script:runtimeCase -ne 'missing-no-opt-in')
        }
        else {
            $target = Join-Path $Root 'bin/nvim.cmd'
            $original = [IO.File]::ReadAllText($target)
            $plan = New-LauncherCandidate '0123456789abcdef'
            if ([IO.File]::ReadAllText($target) -cne $original) { throw 'Preparing a launcher changed the active launcher.' }
            if (-not (Test-Path -LiteralPath $plan.Candidate -PathType Leaf)) { throw 'The launcher candidate was not staged.' }
            $lock = $null
            try {
                if ($inputCase.LauncherTest -eq 'locked-publication') {
                    $lock = [IO.File]::Open($target, [IO.FileMode]::Open, [IO.FileAccess]::Read, [IO.FileShare]::None)
                }
                Publish-Launcher $plan
            }
            finally { if ($lock) { $lock.Dispose() } }
            if (Test-Path -LiteralPath $plan.Candidate) { throw 'Publication did not consume the launcher candidate.' }
            if (-not [IO.File]::ReadAllText($target).Contains('0123456789abcdef')) { throw 'The launcher does not point to the prepared release.' }
        }
    }
    elseif ($inputCase.BundleRoot) {
        $tokens = $null
        $errors = $null
        $ast = [Management.Automation.Language.Parser]::ParseFile($inputCase.Script, [ref]$tokens, [ref]$errors)
        if ($errors.Count -gt 0) { throw ($errors.Message -join '; ') }
        $requiredFunctions = @('Assert-PlainPath', 'Assert-PlainTree', 'Get-BundleFiles', 'Write-Json', 'Assert-BundleFiles')
        $definitions = @($ast.FindAll({
            param($node)
            $node -is [Management.Automation.Language.FunctionDefinitionAst] -and $requiredFunctions -contains $node.Name
        }, $true))
        if ($definitions.Count -ne $requiredFunctions.Count) { throw 'The production bundle functions could not be extracted.' }
        foreach ($definition in $definitions) { . ([scriptblock]::Create($definition.Extent.Text)) }
        $utf8 = New-Object Text.UTF8Encoding($false)
        Write-Json (Join-Path $inputCase.BundleRoot 'bundle.json') ([ordered]@{
            schema_version = 1
            files = @(Get-BundleFiles $inputCase.BundleRoot)
        })
        Assert-BundleFiles $inputCase.BundleRoot
        if ($inputCase.BundleOrderTest) {
            $bundlePath = Join-Path $inputCase.BundleRoot 'bundle.json'
            $bundle = [IO.File]::ReadAllText($bundlePath, $utf8) | ConvertFrom-Json
            if (@($bundle.files).Count -lt 3) { throw 'Bundle ordering fixture needs at least three files.' }
            [array]::Reverse($bundle.files)
            Write-Json $bundlePath $bundle
            Assert-BundleFiles $inputCase.BundleRoot

            $originalHash = $bundle.files[0].sha256
            $bundle.files[0].sha256 = '0' * 64
            Write-Json $bundlePath $bundle
            $hashFailure = $null
            try { Assert-BundleFiles $inputCase.BundleRoot }
            catch { $hashFailure = $_.Exception.Message }
            if ($hashFailure -notmatch 'Cached bundle was modified') { throw 'Bundle verification did not reject the changed hash.' }

            $bundle.files[0].sha256 = $originalHash
            $bundle.files[1] = $bundle.files[0]
            Write-Json $bundlePath $bundle
            $duplicateFailure = $null
            try { Assert-BundleFiles $inputCase.BundleRoot }
            catch { $duplicateFailure = $_.Exception.Message }
            if ($duplicateFailure -notmatch 'Duplicate cached bundle path') { throw 'Bundle verification did not reject the duplicate path.' }
        }
    }
    else {
        $parameters = @{}
        foreach ($entry in $inputCase.Parameters.PSObject.Properties) { $parameters[$entry.Name] = $entry.Value }
        & $inputCase.Script @parameters | Out-Host
    }
}
catch { $failure = $_.Exception.Message }
finally {
    $state = [ordered]@{
        ProcessPathUnchanged = ($env:PATH -ceq $processPathBefore)
        UserPathUnchanged = ([Environment]::GetEnvironmentVariable('PATH', 'User') -ceq $userPathBefore)
        PowerShellDirectory = $PWD.ProviderPath
        ProcessDirectory = $processDirectory
        MockStarts = $script:mockStarts
        SignatureChecks = $script:signatureChecks
    }
    [IO.File]::WriteAllText($inputCase.Result, ($state | ConvertTo-Json), (New-Object Text.UTF8Encoding($false)))
}
if ($failure) { [Console]::Error.WriteLine($failure); exit 1 }
exit 0
'@
    Write-Text (Join-Path $testRoot 'driver.ps1') ($driver + "`n")

    Test-Case 'bootstrap parses in the selected PowerShell version' {
        $fixture = New-Fixture
        $result = Invoke-SetupCase $fixture @{} -ParseOnly
        Assert ($result.Code -eq 0) $result.Output
    }

    Test-Case 'WhatIf leaves roots and PATH unchanged' {
        $fixture = New-Fixture
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime; WhatIf = $true }
        Assert ($result.Code -eq 0) $result.Output
        Assert (-not (Test-Path -LiteralPath $fixture.Runtime)) 'WhatIf created the setup root.'
        Assert (-not (Test-Path -LiteralPath $fixture.LocalAppData)) 'WhatIf created a user profile or backup root.'
    }

    Test-Case 'WhatIf with explicit runtime installation still makes no changes' {
        $fixture = New-Fixture
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime; WhatIf = $true; InstallVCRuntime = $true; PrepareOnly = $true }
        Assert ($result.Code -eq 0) $result.Output
        Assert (-not (Test-Path -LiteralPath $fixture.Runtime)) 'WhatIf with InstallVCRuntime created a setup root.'
        Assert (-not (Test-Path -LiteralPath $fixture.LocalAppData)) 'WhatIf with InstallVCRuntime changed a user profile.'
    }

    foreach ($case in @(
        @{ Name = 'older installed runtime is kept'; Mode = 'present-old'; Error = ''; Starts = 0 },
        @{ Name = 'newer installed runtime is kept'; Mode = 'present-new'; Error = ''; Starts = 0 },
        @{ Name = 'missing runtime requires explicit opt-in'; Mode = 'missing-no-opt-in'; Error = '-InstallVCRuntime'; Starts = 0 },
        @{ Name = 'incomplete newer runtime is not downgraded'; Mode = 'newer-incomplete'; Error = 'will not downgrade'; Starts = 0 },
        @{ Name = 'verified runtime installation is rechecked'; Mode = 'success'; Error = ''; Starts = 1 },
        @{ Name = 'runtime reboot requirement stops preparation'; Mode = 'reboot'; Error = 'requires a Windows restart'; Starts = 1 },
        @{ Name = 'runtime installation error stops preparation'; Mode = 'failure'; Error = 'installation failed \(1603\)'; Starts = 1 },
        @{ Name = 'runtime remains missing after nominal installer success'; Mode = 'not-installed'; Error = 'still unavailable'; Starts = 1 },
        @{ Name = 'cancelled administrator approval stops preparation'; Mode = 'uac-cancelled'; Error = 'approval was cancelled'; Starts = 1 },
        @{ Name = 'unsigned runtime installer is rejected'; Mode = 'unsigned'; Error = 'valid Microsoft Authenticode'; Starts = 0 },
        @{ Name = 'runtime installer from a different publisher is rejected'; Mode = 'wrong-publisher'; Error = 'valid Microsoft Authenticode'; Starts = 0 },
        @{ Name = 'runtime checksum mismatch prevents signature and execution'; Mode = 'bad-hash'; Error = 'Cached archive checksum mismatch'; Starts = 0 }
    )) {
        Test-Case $case.Name {
            $fixture = New-Fixture
            Add-ProfileSentinels $fixture
            $before = Snapshot $fixture.LocalAppData
            $result = Invoke-SetupCase $fixture @{} -RuntimeTest $case.Mode
            if ($case.Error) { Assert-Failure $result $case.Error }
            else { Assert ($result.Code -eq 0) $result.Output }
            Assert ($result.Environment.MockStarts -eq $case.Starts) 'The runtime installer was invoked an unexpected number of times.'
            Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'A runtime prerequisite branch changed user profiles.'
            if ($case.Mode -in @('present-old', 'present-new', 'missing-no-opt-in', 'newer-incomplete')) {
                Assert (-not (Test-Path -LiteralPath $fixture.Runtime)) 'An unneeded runtime operation created files.'
            }
            if ($case.Mode -eq 'bad-hash') { Assert ($result.Environment.SignatureChecks -eq 0) 'Signature validation ran before checksum verification.' }
        }
    }

    Test-Case 'launcher directory is rejected before preparation' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        [void][IO.Directory]::CreateDirectory((Join-Path $fixture.Runtime 'bin/nvim.cmd'))
        $before = Snapshot $fixture.LocalAppData
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime }
        Assert-Failure $result 'launcher destination is a directory'
        Assert (-not (Test-Path -LiteralPath (Join-Path $fixture.Runtime 'downloads'))) 'Launcher preflight ran after preparation began.'
        Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'Launcher rejection changed a user profile.'
    }

    Test-Case 'locked launcher is rejected before preparation' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        $target = Join-Path $fixture.Runtime 'bin/nvim.cmd'
        Write-Text $target "Existing launcher.`n"
        $before = Snapshot $fixture.LocalAppData
        $lock = [IO.File]::Open($target, [IO.FileMode]::Open, [IO.FileAccess]::Read, [IO.FileShare]::None)
        try { $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime } }
        finally { $lock.Dispose() }
        Assert-Failure $result 'launcher is not exclusively writable'
        Assert ([IO.File]::ReadAllText($target) -ceq "Existing launcher.`n") 'Locked launcher contents changed.'
        Assert (-not (Test-Path -LiteralPath (Join-Path $fixture.Runtime 'downloads'))) 'Locked launcher did not stop preparation early.'
        Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'Locked launcher rejection changed a user profile.'
    }

    Test-Case 'launcher junction cannot redirect publication' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        $external = Join-Path $fixture.Path 'external launcher'
        Write-Text (Join-Path $external 'nvim.cmd') "External launcher.`n"
        [void][IO.Directory]::CreateDirectory($fixture.Runtime)
        $null = New-Item -ItemType Junction -Path (Join-Path $fixture.Runtime 'bin') -Target $external
        $before = Snapshot $external
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime }
        Assert-Failure $result 'Reparse points are not supported'
        Assert ((Snapshot $external) -eq $before) 'Launcher preflight wrote through a junction.'
    }

    Test-Case 'launcher candidate preserves the old file until publication' {
        $fixture = New-Fixture
        Write-Text (Join-Path $fixture.Runtime 'bin/nvim.cmd') "Existing launcher.`n"
        $result = Invoke-SetupCase $fixture @{} -LauncherTest 'publish'
        Assert ($result.Code -eq 0) $result.Output
    }

    Test-Case 'late launcher lock preserves the old launcher' {
        $fixture = New-Fixture
        $target = Join-Path $fixture.Runtime 'bin/nvim.cmd'
        Write-Text $target "Existing launcher.`n"
        $result = Invoke-SetupCase $fixture @{} -LauncherTest 'locked-publication'
        Assert-Failure $result 'launcher is not exclusively writable'
        Assert ([IO.File]::ReadAllText($target) -ceq "Existing launcher.`n") 'A publication failure damaged the old launcher.'
    }

    Test-Case 'protected root is rejected before creating a profile' {
        $fixture = New-Fixture
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.LocalAppData; PrepareOnly = $true }
        Assert-Failure $result 'protected directory'
        Assert (-not (Test-Path -LiteralPath $fixture.LocalAppData)) 'Rejected setup created a protected root.'
    }

    Test-Case 'repository root is protected' {
        $fixture = New-Fixture
        $result = Invoke-SetupCase $fixture @{ Root = $repository; PrepareOnly = $true }
        Assert-Failure $result 'protected directory'
    }

    foreach ($targetName in @('ConfigPath', 'DataPath', 'BackupRoot')) {
        Test-Case "overlapping $targetName is rejected" {
            $fixture = New-Fixture
            $parameters = @{ Root = $fixture.Runtime; PrepareOnly = $true }
            $parameters[$targetName] = Join-Path $fixture.Runtime 'nested profile'
            $result = Invoke-SetupCase $fixture $parameters
            Assert-Failure $result 'must not overlap'
            Assert (-not (Test-Path -LiteralPath $fixture.Runtime)) 'Rejected overlap created the setup root.'
        }
    }

    Test-Case 'relative Root uses the PowerShell working directory' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        $expectedRoot = Join-Path $fixture.Location 'relative runtime'
        $archive = Add-CorruptArchive $expectedRoot
        $before = Snapshot $fixture.LocalAppData
        $result = Invoke-SetupCase $fixture @{ Root = 'relative runtime'; PrepareOnly = $true }
        Assert-Failure $result 'Cached archive checksum mismatch'
        Assert ($result.Output.Contains($archive)) 'The checksum failure did not reference the PowerShell-relative archive.'
        Assert ($result.Environment.PowerShellDirectory -ne $result.Environment.ProcessDirectory) 'The fixture did not distinguish PowerShell and process working directories.'
        Assert (-not (Test-Path -LiteralPath (Join-Path $fixture.ProcessDirectory 'relative runtime'))) 'Setup resolved Root against the process working directory.'
        Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'Relative-root failure changed a user profile.'
    }

    Test-Case 'corrupt cached archive fails offline and preserves profiles' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        $archive = Add-CorruptArchive $fixture.Runtime
        $archiveHash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash
        $before = Snapshot $fixture.LocalAppData
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime; PrepareOnly = $true }
        Assert-Failure $result 'Cached archive checksum mismatch'
        Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'Checksum failure changed a profile or its backups.'
        Assert ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -eq $archiveHash) 'Setup modified the corrupt archive.'
        Assert (@(Get-ChildItem -LiteralPath $fixture.Runtime -Recurse -Force -Filter '.git').Count -eq 0) 'Setup initialized Git after a checksum failure.'
    }

    Test-Case 'cache child junction is rejected before external writes' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        $external = Join-Path $fixture.Path 'outside runtime'
        Write-Text (Join-Path $external 'sentinel.txt') "External files must survive unchanged.`n"
        $junction = Join-Path $fixture.Runtime 'cache/gopath/pkg/mod'
        [void][IO.Directory]::CreateDirectory((Split-Path -Parent $junction))
        $null = New-Item -ItemType Junction -Path $junction -Target $external
        $before = Snapshot $external
        $profilesBefore = Snapshot $fixture.LocalAppData
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime; PrepareOnly = $true }
        Assert-Failure $result 'Reparse points are not supported'
        Assert ((Snapshot $external) -eq $before) 'Setup wrote through a cache junction.'
        Assert ((Snapshot $fixture.LocalAppData) -eq $profilesBefore) 'Junction rejection changed the user profiles.'
        Assert ((Get-Item -LiteralPath $junction -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) 'Setup removed the junction.'
    }

    Test-Case 'malformed plugin name fails before downloads or Git initialization' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        $copyScript = Copy-SetupFixture $fixture
        $lockPath = Join-Path (Split-Path -Parent $copyScript) 'runtime-lock.json'
        $manifest = [IO.File]::ReadAllText($lockPath) | ConvertFrom-Json
        $pluginValue = @($manifest.plugins.PSObject.Properties)[0].Value
        $manifest.plugins = [pscustomobject]@{ '../escape' = $pluginValue }
        Write-Text $lockPath (($manifest | ConvertTo-Json -Depth 20) + "`n")
        $before = Snapshot $fixture.LocalAppData
        $result = Invoke-SetupCase $fixture @{ Root = $fixture.Runtime; PrepareOnly = $true } -Script $copyScript
        Assert-Failure $result 'Invalid plugin entry'
        Assert (-not (Test-Path -LiteralPath $fixture.Runtime)) 'Malformed plugin created a setup root.'
        Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'Malformed plugin changed a user profile.'
        Assert (@(Get-ChildItem -LiteralPath $fixture.Path -Recurse -Force -Filter '.git').Count -eq 0) 'Malformed plugin initialized Git.'
    }

    Test-Case 'bundle JSON round-trip preserves a Unicode Go SDK filename' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        $unicodePath = 'data/nvim-data/tools/go/test/fixedbugs/issue27836.dir/' + [char]0x00de + 'foo.go'
        Write-Text (Join-Path $fixture.Runtime $unicodePath) "package fixture`n"
        Write-Text (Join-Path $fixture.Runtime 'runtime/bin/nvim.exe') "Fixture executable, never run.`n"
        Write-Text (Join-Path $fixture.Runtime 'config/nvim/init.lua') "return {}`n"
        $before = Snapshot $fixture.LocalAppData
        $result = Invoke-SetupCase $fixture @{} -BundleRoot $fixture.Runtime
        Assert ($result.Code -eq 0) "Production bundle functions failed on a Unicode filename:`n$($result.Output)"
        $manifestPath = Join-Path $fixture.Runtime 'bundle.json'
        $bytes = [IO.File]::ReadAllBytes($manifestPath)
        Assert (-not ($bytes.Length -ge 3 -and $bytes[0] -eq 0xef -and $bytes[1] -eq 0xbb -and $bytes[2] -eq 0xbf)) 'The regression fixture must exercise BOMless UTF-8 JSON.'
        $manifest = [IO.File]::ReadAllText($manifestPath, $utf8) | ConvertFrom-Json
        $entry = @($manifest.files | Where-Object { $_.path -ceq $unicodePath })
        Assert ($entry.Count -eq 1) 'The Unicode filename did not survive the real bundle writer.'
        Assert ($entry[0].sha256 -eq (Get-FileHash -LiteralPath (Join-Path $fixture.Runtime $unicodePath) -Algorithm SHA256).Hash) 'The Unicode file hash changed in the bundle manifest.'
        Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'Bundle verification changed a user profile.'
    }

    Test-Case 'bundle verification ignores manifest order and rejects changed hashes and duplicate paths' {
        $fixture = New-Fixture
        Add-ProfileSentinels $fixture
        foreach ($filename in @('markdown.dll', 'markdown_inline.dll', 'query.dll')) {
            Write-Text (Join-Path $fixture.Runtime ('runtime/parser/' + $filename)) "Parser fixture: $filename`n"
        }
        Write-Text (Join-Path $fixture.Runtime 'config/nvim/init.lua') "return {}`n"
        Write-Text (Join-Path $fixture.Runtime 'data/nvim-data/runtime.txt') "Runtime fixture.`n"
        $before = Snapshot $fixture.LocalAppData
        $result = Invoke-SetupCase $fixture @{} -BundleRoot $fixture.Runtime -BundleOrderTest
        Assert ($result.Code -eq 0) "Production bundle verification failed the ordering regression:`n$($result.Output)"
        Assert ((Snapshot $fixture.LocalAppData) -eq $before) 'Bundle ordering verification changed a user profile.'
    }

    Write-Output "$script:passed bootstrap checks passed."
}
finally {
    if (Test-Path -LiteralPath $testRoot) {
        $resolvedRoot = [IO.Path]::GetFullPath($testRoot)
        Assert ([IO.Path]::GetDirectoryName($resolvedRoot) -eq [IO.Path]::GetFullPath($buildRoot)) 'Cleanup root left .build.'
        Assert ([IO.Path]::GetFileName($resolvedRoot) -match '^setup-tests-[a-f0-9]{32}$') 'Unexpected cleanup root name.'
        # Delete junction entries without descending into their targets.
        $pending = New-Object 'Collections.Generic.Queue[string]'
        $pending.Enqueue($resolvedRoot)
        while ($pending.Count -gt 0) {
            foreach ($item in Get-ChildItem -LiteralPath $pending.Dequeue() -Force) {
                $safePath = Assert-WithinTests $item.FullName
                if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                    if ($item.PSIsContainer) { [IO.Directory]::Delete($safePath) }
                    else { [IO.File]::Delete($safePath) }
                }
                elseif ($item.PSIsContainer) { $pending.Enqueue($safePath) }
            }
        }
        Remove-Item -LiteralPath $resolvedRoot -Recurse -Force
    }
}
