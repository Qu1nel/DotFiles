[CmdletBinding()]
param(
    [string]$NvimPath = 'nvim',
    [string]$PowerShellPath
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$checkScript = Join-Path $repository 'scripts/windows/check.ps1'
$installScript = Join-Path $repository 'scripts/windows/install-hooks.ps1'
if (-not $PowerShellPath) { $PowerShellPath = (Get-Process -Id $PID).Path }
$utf8 = New-Object System.Text.UTF8Encoding($false)
$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('dotfiles-workflow-' + [guid]::NewGuid().ToString('N'))
$script:count = 0
$script:caseNumber = 0

function Quote-Argument([string]$Value) {
    $quoted = [regex]::Replace($Value, '(\\*)"', '$1$1\"')
    $quoted = [regex]::Replace($quoted, '(\\+)$', '$1$1')
    return '"' + $quoted + '"'
}

function Invoke-Captured([string]$Executable, [string[]]$Arguments) {
    $info = New-Object System.Diagnostics.ProcessStartInfo
    $info.FileName = $Executable
    $info.Arguments = (($Arguments | ForEach-Object { Quote-Argument $_ }) -join ' ')
    $info.UseShellExecute = $false
    $info.CreateNoWindow = $true
    $info.RedirectStandardOutput = $true
    $info.RedirectStandardError = $true
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $info
    try {
        [void]$process.Start()
        $outTask = $process.StandardOutput.ReadToEndAsync()
        $errTask = $process.StandardError.ReadToEndAsync()
        $process.WaitForExit()
        return @{ Code = $process.ExitCode; Output = $outTask.GetAwaiter().GetResult() + $errTask.GetAwaiter().GetResult() }
    }
    finally { $process.Dispose() }
}

function Invoke-FixtureGit([string]$Fixture, [string[]]$Arguments) {
    $result = Invoke-Captured 'git' (@('-C', $Fixture) + $Arguments)
    if ($result.Code -ne 0) { throw $result.Output }
    return $result.Output
}

function New-Fixture {
    $script:caseNumber++
    $fixture = Join-Path $testRoot ('case ' + $script:caseNumber)
    [void][System.IO.Directory]::CreateDirectory($fixture)
    $null = Invoke-FixtureGit $fixture @('init', '--quiet')
    $null = Invoke-FixtureGit $fixture @('config', '--local', 'core.autocrlf', 'false')
    return $fixture
}

function Write-Fixture([string]$Fixture, [string]$Name, [string]$Content) {
    $path = Join-Path $Fixture $Name
    [void][System.IO.Directory]::CreateDirectory((Split-Path -Parent $path))
    [System.IO.File]::WriteAllText($path, $Content, $utf8)
}

function Assert-Result([string]$Label, [hashtable]$Result, [bool]$ExpectedPass) {
    if (($Result.Code -eq 0) -ne $ExpectedPass) {
        throw "$Label failed: exit $($Result.Code)`n$($Result.Output)"
    }
    $script:count++
    Write-Output "PASS $Label"
}

function Invoke-Check([string]$Fixture) {
    return Invoke-Captured $PowerShellPath @('-NoProfile', '-NonInteractive', '-ExecutionPolicy', 'Bypass', '-File', $checkScript, '-Staged', '-Repository', $Fixture, '-NvimPath', $NvimPath)
}

function Test-StagedFile([string]$Label, [string]$Name, [string]$Content, [bool]$ExpectedPass) {
    $fixture = New-Fixture
    Write-Fixture $fixture $Name $Content
    $null = Invoke-FixtureGit $fixture @('add', '--', $Name)
    Assert-Result $Label (Invoke-Check $fixture) $ExpectedPass
}

function Test-Message([string]$Label, [string]$Message, [bool]$ExpectedPass) {
    $fixture = New-Fixture
    $path = Join-Path $fixture 'message.txt'
    [System.IO.File]::WriteAllText($path, ($Message + "`n"), $utf8)
    $result = Invoke-Captured $PowerShellPath @('-NoProfile', '-NonInteractive', '-ExecutionPolicy', 'Bypass', '-File', $checkScript, '-CommitMessageFile', $path)
    Assert-Result $Label $result $ExpectedPass
}

try {
    [void][System.IO.Directory]::CreateDirectory($testRoot)
    Test-StagedFile 'valid Lua' 'nvim/windows/config/init.lua' "local value = 1`nreturn value`n" $true
    Test-StagedFile 'invalid Lua' 'nvim/windows/config/init.lua' "local = 1`n" $false
    Test-StagedFile 'valid PowerShell' 'scripts/windows/example.ps1' "Write-Output 'ok'`n" $true
    Test-StagedFile 'invalid PowerShell' 'scripts/windows/example.ps1' "if (`n" $false
    Test-StagedFile 'valid JSON' 'nvim/windows/runtime-lock.json' "{`"version`": 1}`n" $true
    Test-StagedFile 'valid npm empty-key JSON' 'nvim/windows/tools/package-lock.json' "{`"packages`": {`"`": {`"name`": `"fixture`"}}}`n" $true
    Test-StagedFile 'invalid JSON' 'nvim/windows/runtime-lock.json' "{`"version`": }`n" $false
    Test-StagedFile 'empty JSON' 'nvim/windows/runtime-lock.json' "`n" $false
    Test-StagedFile 'trailing whitespace' 'README.md' "Text `n" $false
    Test-StagedFile 'conflict marker' 'README.md' "<<<<<<< HEAD`ntext`n" $false
    Test-StagedFile 'private key' 'secret.pem' "-----BEGIN PRIVATE KEY-----`n" $false
    Test-StagedFile 'missing final newline' 'README.md' 'Text' $false
    Test-StagedFile 'local agent instructions' 'AGENTS.md' "Local instructions.`n" $false
    Test-StagedFile 'local agent directory' '.agents/skills/example/SKILL.md' "Local instructions.`n" $false
    Test-StagedFile 'generated runtime' 'nvim/windows/cache/state.json' "{}`n" $false
    Test-StagedFile 'Neovim fallback log' '.nvimlog' "Log.`n" $false
    Test-StagedFile 'backup file' 'nvim/windows/config/init.lua.bak' "return {}`n" $false
    Test-StagedFile 'UTF-8 BOM' 'README.md' ([string][char]0xfeff + "Text`n") $false
    Test-StagedFile 'NUL byte cannot skip source checks' 'scripts/windows/example.ps1' ("if (`n" + [char]0) $false
    $unicodeName = 'nvim/windows/caf' + [char]0xe9 + " file's.lua"
    Test-StagedFile 'spaces Unicode and apostrophes in path' $unicodeName "return {}`n" $true

    $fixture = New-Fixture
    Write-Fixture $fixture 'nvim/windows/config/init.lua' "local = 1`n"
    $null = Invoke-FixtureGit $fixture @('add', '--', 'nvim/windows/config/init.lua')
    Write-Fixture $fixture 'nvim/windows/config/init.lua' "return {}`n"
    Assert-Result 'reject broken index with fixed working tree' (Invoke-Check $fixture) $false

    $fixture = New-Fixture
    Write-Fixture $fixture 'nvim/windows/config/init.lua' "return {}`n"
    $null = Invoke-FixtureGit $fixture @('add', '--', 'nvim/windows/config/init.lua')
    Write-Fixture $fixture 'nvim/windows/config/init.lua' "local = 1`n"
    Assert-Result 'accept valid index with broken working tree' (Invoke-Check $fixture) $true

    Test-Message 'conventional message' 'fix(nvim): preserve modified buffers' $true
    Test-Message 'optional scope' 'docs: explain the Windows setup' $true
    Test-Message 'breaking change marker' 'feat(nvim)!: replace the Windows profile' $true
    Test-Message 'missing conventional prefix' 'Update stuff' $false
    Test-Message 'long header' ('fix(nvim): ' + ('x' * 70)) $false
    Test-Message 'non-ASCII header' ('fix: ' + [char]0x438 + [char]0x441 + [char]0x43f) $false
    Test-Message 'generated attribution' "fix(nvim): repair startup`n`nGenerated by Codex" $false
    Test-Message 'assistant trailer' "fix(nvim): repair startup`n`nCo-Authored-By: Codex <agent@example.invalid>" $false
    Test-Message 'merge template needs deliberate message' "Merge branch 'feature'" $false
    Test-Message 'revert template needs deliberate message' 'Revert "fix(nvim): repair startup"' $false
    Test-Message 'conventional revert' 'revert(nvim): restore previous startup' $true

    $fixture = New-Fixture
    [void][System.IO.Directory]::CreateDirectory((Join-Path $fixture '.githooks'))
    foreach ($hook in @('pre-commit', 'commit-msg')) {
        Copy-Item -LiteralPath (Join-Path $repository ".githooks/$hook") -Destination (Join-Path $fixture ".githooks/$hook")
    }
    $installArguments = @('-NoProfile', '-NonInteractive', '-ExecutionPolicy', 'Bypass', '-File', $installScript, '-Repository', $fixture)
    Assert-Result 'install local hooks' (Invoke-Captured $PowerShellPath $installArguments) $true
    Assert-Result 'install hooks twice' (Invoke-Captured $PowerShellPath $installArguments) $true
    if ((Invoke-FixtureGit $fixture @('config', '--local', '--get', 'core.hooksPath')).Trim() -ne '.githooks') {
        throw 'The local hook path was not saved.'
    }
    [void][System.IO.Directory]::CreateDirectory((Join-Path $fixture 'scripts/windows'))
    Copy-Item -LiteralPath $checkScript -Destination (Join-Path $fixture 'scripts/windows/check.ps1')
    $null = Invoke-FixtureGit $fixture @('config', '--local', 'user.name', 'Workflow Test')
    $null = Invoke-FixtureGit $fixture @('config', '--local', 'user.email', 'workflow@example.invalid')
    $null = Invoke-FixtureGit $fixture @('config', '--local', 'commit.gpgsign', 'false')
    Write-Fixture $fixture 'README.md' "Fixture.`n"
    $null = Invoke-FixtureGit $fixture @('add', '--', 'README.md')
    Assert-Result 'Git invokes valid hooks' (Invoke-Captured 'git' @('-C', $fixture, 'commit', '--quiet', '-m', 'test: verify installed hooks')) $true
    Write-Fixture $fixture 'nvim/windows/runtime-lock.json' "{`n"
    $null = Invoke-FixtureGit $fixture @('add', '--', 'nvim/windows/runtime-lock.json')
    $rejectedContent = Invoke-Captured 'git' @('-C', $fixture, 'commit', '--quiet', '-m', 'test: reject broken content')
    Assert-Result 'pre-commit rejects invalid staged content' $rejectedContent $false
    if ($rejectedContent.Output -notmatch 'invalid JSON') { throw 'The pre-commit hook failed for an unexpected reason.' }
    Write-Fixture $fixture 'nvim/windows/runtime-lock.json' "{}`n"
    $null = Invoke-FixtureGit $fixture @('add', '--', 'nvim/windows/runtime-lock.json')
    $rejectedMessage = Invoke-Captured 'git' @('-C', $fixture, 'commit', '--quiet', '-m', 'Bad message')
    Assert-Result 'commit-msg rejects invalid header' $rejectedMessage $false
    if ($rejectedMessage.Output -notmatch 'Use type') { throw 'The commit-msg hook failed for an unexpected reason.' }
    $null = Invoke-FixtureGit $fixture @('config', '--local', 'core.hooksPath', 'other-hooks')
    Assert-Result 'preserve existing hook path' (Invoke-Captured $PowerShellPath $installArguments) $false
    if ((Invoke-FixtureGit $fixture @('config', '--local', '--get', 'core.hooksPath')).Trim() -ne 'other-hooks') {
        throw 'An existing hook path was overwritten.'
    }
    $fixture = New-Fixture
    Write-Fixture $fixture '.git/hooks/pre-commit' "#!/bin/sh`nexit 0`n"
    $defaultHookResult = Invoke-Captured $PowerShellPath @('-NoProfile', '-NonInteractive', '-ExecutionPolicy', 'Bypass', '-File', $installScript, '-Repository', $fixture)
    Assert-Result 'preserve existing default hook' $defaultHookResult $false
    if ($defaultHookResult.Output -notmatch 'would be bypassed') { throw 'Default hook detection failed for an unexpected reason.' }
    Write-Output "$script:count workflow checks passed."
}
finally {
    if (Test-Path -LiteralPath $testRoot) {
        $resolvedRoot = [System.IO.Path]::GetFullPath($testRoot)
        $expectedParent = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\', '/')
        if ([System.IO.Path]::GetDirectoryName($resolvedRoot) -ne $expectedParent -or
            [System.IO.Path]::GetFileName($resolvedRoot) -notmatch '^dotfiles-workflow-[a-f0-9]{32}$') {
            throw 'Refusing to remove an unexpected test directory.'
        }
        Remove-Item -LiteralPath $resolvedRoot -Recurse -Force
    }
}
