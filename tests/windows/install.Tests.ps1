[CmdletBinding()]
param([switch] $KeepArtifacts)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$repoRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$installer = Join-Path $repoRoot 'nvim/windows/install.ps1'
$testRoot = Join-Path $repoRoot ('.build/install-tests-' + [Guid]::NewGuid().ToString('N'))
$null = New-Item -ItemType Directory -Path $testRoot -Force
$passed = 0

function Assert([bool] $Condition, [string] $Message) {
    if (-not $Condition) { throw $Message }
}

function Write-Text([string] $Path, [string] $Text) {
    $parent = [IO.Path]::GetDirectoryName($Path)
    if (-not (Test-Path -LiteralPath $parent)) { $null = New-Item -ItemType Directory -Path $parent -Force }
    [IO.File]::WriteAllText($Path, $Text, [Text.UTF8Encoding]::new($false))
}

function New-Fixture([string] $Name, [switch] $Existing) {
    $root = Join-Path $testRoot $Name
    $fixture = @{
        SourcePath = (Join-Path $root 'source')
        PreparedDataPath = (Join-Path $root 'prepared')
        ConfigPath = (Join-Path $root 'active config')
        DataPath = (Join-Path $root 'active data')
        BackupRoot = (Join-Path $root 'backups')
    }
    Write-Text (Join-Path $fixture.SourcePath 'init.lua') 'vim.opt.number = true'
    $pluginLockText = [IO.File]::ReadAllText((Join-Path $repoRoot 'nvim/windows/config/lazy-lock.json'))
    Write-Text (Join-Path $fixture.SourcePath 'lazy-lock.json') $pluginLockText
    Write-Text (Join-Path $fixture.PreparedDataPath 'lazy/mini.nvim/lua/mini/files.lua') 'return {}'
    Write-Text (Join-Path $fixture.PreparedDataPath 'lazy/lazy.nvim/lua/lazy/init.lua') 'return {}'
    $pluginLock = $pluginLockText | ConvertFrom-Json
    foreach ($plugin in $pluginLock.PSObject.Properties) {
        Write-Text (Join-Path $fixture.PreparedDataPath ('lazy/' + $plugin.Name + '/.git/HEAD')) $plugin.Value.commit
    }
    foreach ($tool in @('ruff', 'gopls', 'taplo', 'rg')) { Write-Text (Join-Path $fixture.PreparedDataPath ('tools/bin/' + $tool + '.exe')) 'fixture-tool' }
    $runtimeLockPath = Join-Path $repoRoot 'nvim/windows/runtime-lock.json'
    $runtimeLock = [IO.File]::ReadAllText($runtimeLockPath) | ConvertFrom-Json
    $descriptor = @{
        schema_version = 1; nvim_version = $runtimeLock.downloads.neovim.version
        runtime_lock_sha256 = (Get-FileHash -LiteralPath $runtimeLockPath -Algorithm SHA256).Hash
        plugin_lock_sha256 = (Get-FileHash -LiteralPath (Join-Path $fixture.SourcePath 'lazy-lock.json') -Algorithm SHA256).Hash
        required_files = @('tools/bin/ruff.exe')
    }
    Write-Text (Join-Path $fixture.PreparedDataPath 'dotfiles-runtime.json') ($descriptor | ConvertTo-Json -Depth 10)
    if ($Existing) {
        Write-Text (Join-Path $fixture.ConfigPath 'init.lua') 'old config'
        Write-Text (Join-Path $fixture.DataPath 'old-data.txt') 'old data'
    }
    return $fixture
}

function Get-Snapshot([string] $Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return '<absent>' }
    $lines = foreach ($item in Get-ChildItem -LiteralPath $Path -Recurse -Force | Sort-Object FullName) {
        $relative = $item.FullName.Substring($Path.Length)
        if ($item.PSIsContainer) { "directory $relative" }
        else { "file $relative $((Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash)" }
    }
    return ($lines -join "`n")
}

function Get-Backups([hashtable] $Fixture) {
    return @(Get-ChildItem -LiteralPath $Fixture.BackupRoot -Directory | Sort-Object Name)
}

function Assert-Rejected([scriptblock] $Action, [string] $Pattern) {
    $caught = $null
    try { & $Action | Out-Null } catch { $caught = $_.Exception.Message }
    Assert ($null -ne $caught) 'Expected the operation to fail.'
    Assert ($caught -match $Pattern) "Unexpected failure: $caught"
}

function Test-Case([string] $Name, [scriptblock] $Action) {
    & $Action
    $script:passed++
    Write-Output "PASS $Name"
}

try {
    Test-Case 'WhatIf does not create or modify files' {
        $f = New-Fixture 'whatif' -Existing
        $root = Split-Path $f.SourcePath -Parent
        $before = Get-Snapshot $root
        & $installer @f -WhatIf | Out-Null
        Assert ((Get-Snapshot $root) -eq $before) 'WhatIf changed the fixture.'
    }

    Test-Case 'Physical AppData redirection is rejected before moving profiles' {
        $driver = Join-Path $testRoot 'physical-path-driver.ps1'
        Write-Text $driver @'
param([string] $InputPath)
$ErrorActionPreference = 'Stop'
$inputCase = [IO.File]::ReadAllText($InputPath) | ConvertFrom-Json
Add-Type -TypeDefinition @"
using System;
using System.IO;
public static class DotFilesWindowsInstallerPathsV1 {
    public static string Mode;
    public static string Resolve(string path) {
        string name = Path.GetFileName(path);
        bool redirected = (Mode == "backup" && name == "backups") ||
            (Mode == "config" && name.StartsWith(".dotfiles-config-")) ||
            (Mode == "data" && name.StartsWith(".dotfiles-data-")) ||
            (Mode == "existing" && name == "active config");
        return @"\\?\" + (redirected ? Path.Combine(Path.GetDirectoryName(path), "redirected-" + name) : path);
    }
}
"@
[DotFilesWindowsInstallerPathsV1]::Mode = $inputCase.Mode
$parameters = @{}
foreach ($entry in $inputCase.Parameters.PSObject.Properties) { $parameters[$entry.Name] = $entry.Value }
$failure = $null
try { & $inputCase.Installer @parameters | Out-Null }
catch { $failure = $_.Exception.Message }
[IO.File]::WriteAllText($inputCase.Result, ([pscustomobject]@{ Error = $failure } | ConvertTo-Json), (New-Object Text.UTF8Encoding($false)))
'@
        $shell = (Get-Process -Id $PID).Path
        foreach ($mode in @('backup', 'config', 'data', 'existing')) {
            $f = New-Fixture ('redirected-' + $mode) -Existing
            $beforeConfig = Get-Snapshot $f.ConfigPath
            $beforeData = Get-Snapshot $f.DataPath
            $inputPath = Join-Path $testRoot ('physical-' + $mode + '.json')
            $resultPath = Join-Path $testRoot ('physical-' + $mode + '-result.json')
            Write-Text $inputPath (@{ Installer = $installer; Parameters = $f; Mode = $mode; Result = $resultPath } | ConvertTo-Json -Depth 10)
            & $shell -NoProfile -ExecutionPolicy Bypass -File $driver -InputPath $inputPath
            Assert ($LASTEXITCODE -eq 0) 'The physical-path regression driver failed.'
            $result = [IO.File]::ReadAllText($resultPath) | ConvertFrom-Json
            Assert ($result.Error -match 'AppData redirected by packaged host, rerun in ordinary PowerShell') "Physical $mode redirection was not rejected: $($result.Error)"
            Assert ((Get-Snapshot $f.ConfigPath) -eq $beforeConfig) 'Physical-path rejection changed the existing configuration.'
            Assert ((Get-Snapshot $f.DataPath) -eq $beforeData) 'Physical-path rejection changed the existing data.'
            if (Test-Path -LiteralPath $f.BackupRoot) {
                Assert (@(Get-Backups $f).Count -eq 0) 'Physical-path rejection moved files into a backup.'
            }
        }
    }

    Test-Case 'Install preserves old config and data in a verified backup' {
        $f = New-Fixture 'install' -Existing
        & $installer @f | Out-Null
        Assert ((Get-Content -LiteralPath (Join-Path $f.ConfigPath 'init.lua') -Raw) -eq 'vim.opt.number = true') 'New config was not installed.'
        $backups = @(Get-Backups $f)
        Assert ($backups.Count -eq 1) 'Expected one backup.'
        Assert ((Get-Content -LiteralPath (Join-Path $backups[0].FullName 'config/init.lua') -Raw) -eq 'old config') 'Old config was not preserved.'
        Assert ((Get-Content -LiteralPath (Join-Path $backups[0].FullName 'data/old-data.txt') -Raw) -eq 'old data') 'Old data was not preserved.'
    }

    Test-Case 'Repeated install is a no-op, allowing runtime data and Git metadata' {
        $f = New-Fixture 'repeat'
        & $installer @f | Out-Null
        Write-Text (Join-Path $f.DataPath 'logs/runtime.log') 'new runtime log'
        Write-Text (Join-Path $f.DataPath 'lazy/mini.nvim/.git/logs/HEAD') 'changed metadata'
        $root = Split-Path $f.SourcePath -Parent
        $before = Get-Snapshot $root
        $result = & $installer @f
        Assert ($result -match 'Already installed') 'Repeated install did not report no-op.'
        Assert ((Get-Snapshot $root) -eq $before) 'Repeated install changed files.'
    }

    Test-Case 'Changed and deleted runtime state do not invalidate an installed bundle' {
        $f = New-Fixture 'changed-runtime'
        Write-Text (Join-Path $f.PreparedDataPath 'state/dotfiles-lazy/state.json') '{"prepared":true}'
        Write-Text (Join-Path $f.PreparedDataPath 'nvim.log') 'preparation log'
        Write-Text (Join-Path $f.PreparedDataPath 'undo/prepared.undo') 'prepared undo history'
        & $installer @f | Out-Null
        Write-Text (Join-Path $f.DataPath 'state/dotfiles-lazy/state.json') '{"used":true}'
        Write-Text (Join-Path $f.DataPath 'nvim.log') 'changed runtime log'
        Remove-Item -LiteralPath (Join-Path $f.DataPath 'undo/prepared.undo')
        Write-Text (Join-Path $f.DataPath 'shada/main.shada') 'new runtime history'
        $before = Get-Snapshot $f.DataPath
        $result = & $installer @f
        Assert ($result -match 'Already installed') 'Changed runtime state prevented a no-op install.'
        Assert ((Get-Snapshot $f.DataPath) -eq $before) 'Repeated install changed runtime state.'
        $receipt = [IO.File]::ReadAllText((Join-Path $f.ConfigPath '.dotfiles-install.json')) | ConvertFrom-Json
        Assert (@($receipt.DataFiles | Where-Object { $_.Path -match '^(state|undo|nvim\.log)(/|$)' }).Count -eq 0) 'Runtime state leaked into the managed file receipt.'
    }

    Test-Case 'Runtime state remains covered by full backup integrity checks' {
        $f = New-Fixture 'runtime-backup'
        & $installer @f | Out-Null
        Write-Text (Join-Path $f.DataPath 'state/dotfiles-lazy/state.json') '{"used":true}'
        Write-Text (Join-Path $f.DataPath 'nvim.log') 'runtime log'
        Write-Text (Join-Path $f.SourcePath 'init.lua') 'vim.opt.number = false'
        & $installer @f | Out-Null
        $latest = @(Get-Backups $f)[-1]
        $backedState = Join-Path $latest.FullName 'data/state/dotfiles-lazy/state.json'
        Assert ((Get-Content -LiteralPath $backedState -Raw) -eq '{"used":true}') 'Runtime state was not backed up.'
        Write-Text $backedState '{"tampered":true}'
        Assert-Rejected { & $installer @f -Restore $latest.FullName } 'integrity check failed'
    }

    Test-Case 'Local config changes require Force and are backed up' {
        $f = New-Fixture 'modified-config'
        & $installer @f | Out-Null
        Write-Text (Join-Path $f.ConfigPath 'init.lua') 'my config'
        $before = Get-Snapshot $f.ConfigPath
        Assert-Rejected { & $installer @f } 'has changed'
        Assert ((Get-Snapshot $f.ConfigPath) -eq $before) 'Rejected install changed local config.'
        & $installer @f -Force | Out-Null
        $latest = @(Get-Backups $f)[-1]
        Assert ((Get-Content -LiteralPath (Join-Path $latest.FullName 'config/init.lua') -Raw) -eq 'my config') 'Force lost local config.'
    }

    Test-Case 'Changed managed plugin files require Force' {
        $f = New-Fixture 'modified-plugin'
        & $installer @f | Out-Null
        Write-Text (Join-Path $f.DataPath 'lazy/mini.nvim/lua/mini/files.lua') 'local plugin update'
        Assert-Rejected { & $installer @f } 'has changed'
        Assert ((Get-Content -LiteralPath (Join-Path $f.DataPath 'lazy/mini.nvim/lua/mini/files.lua') -Raw) -eq 'local plugin update') 'Plugin changes were overwritten.'
    }

    Test-Case 'Changed installed plugin revisions require Force' {
        $f = New-Fixture 'modified-plugin-head'
        & $installer @f | Out-Null
        Write-Text (Join-Path $f.DataPath 'lazy/mini.nvim/.git/HEAD') ('a' * 40)
        Assert-Rejected { & $installer @f } 'has changed'
    }

    Test-Case 'Added plugin code is protected from an unchanged reinstall' {
        $f = New-Fixture 'added-plugin-code'
        & $installer @f | Out-Null
        $added = Join-Path $f.DataPath 'lazy/mini.nvim/plugin/unexpected.lua'
        Write-Text $added 'vim.g.local_plugin = true'
        Assert-Rejected { & $installer @f } 'has changed'
        Assert (Test-Path -LiteralPath $added) 'Rejected installation lost the added plugin.'
        & $installer @f -Force | Out-Null
        $latest = @(Get-Backups $f)[-1]
        Assert (Test-Path -LiteralPath (Join-Path $latest.FullName 'data/lazy/mini.nvim/plugin/unexpected.lua')) 'Force did not preserve added code in the backup.'
    }

    Test-Case 'Added tools and native runtime plugins require Force' {
        foreach ($relative in @('tools/bin/extra.exe', 'site/plugin/unexpected.lua')) {
            $f = New-Fixture ('added-runtime-' + [Guid]::NewGuid().ToString('N'))
            & $installer @f | Out-Null
            $added = Join-Path $f.DataPath $relative
            Write-Text $added 'extra runtime code'
            Assert-Rejected { & $installer @f } 'has changed'
            Assert (Test-Path -LiteralPath $added) 'Rejected installation lost added runtime code.'
        }
    }

    Test-Case 'Incomplete prepared bundles and mismatched commits are rejected' {
        $f = New-Fixture 'incomplete-prepared'
        $missing = Join-Path $f.PreparedDataPath 'tools/bin/ruff.exe'
        Remove-Item -LiteralPath $missing
        Assert-Rejected { & $installer @f } 'missing a required file'
        Write-Text $missing 'fixture-tool'
        Write-Text (Join-Path $f.PreparedDataPath 'lazy/mini.nvim/.git/HEAD') ('a' * 40)
        Assert-Rejected { & $installer @f } 'Plugin commit does not match'
        Assert (-not (Test-Path -LiteralPath $f.ConfigPath)) 'Invalid bundle created active config.'
    }

    Test-Case 'Prepared descriptor checksum and file traversal are rejected' {
        $f = New-Fixture 'descriptor'
        $descriptorPath = Join-Path $f.PreparedDataPath 'dotfiles-runtime.json'
        $original = Get-Content -LiteralPath $descriptorPath -Raw
        $descriptor = $original | ConvertFrom-Json
        $descriptor.plugin_lock_sha256 = 'wrong'
        Write-Text $descriptorPath ($descriptor | ConvertTo-Json -Depth 10)
        Assert-Rejected { & $installer @f } 'does not match the source lazy-lock.json'
        $descriptor = $original | ConvertFrom-Json
        $descriptor.required_files = @('../escape')
        Write-Text $descriptorPath ($descriptor | ConvertTo-Json -Depth 10)
        Assert-Rejected { & $installer @f } 'Invalid prepared bundle file path'
    }

    Test-Case 'Restore replaces config and data together and backs up current state' {
        $f = New-Fixture 'restore' -Existing
        & $installer @f | Out-Null
        $first = @(Get-Backups $f)[0]
        $newConfig = Get-Snapshot $f.ConfigPath
        $newData = Get-Snapshot $f.DataPath
        & $installer @f -Restore $first.FullName | Out-Null
        Assert ((Get-Content -LiteralPath (Join-Path $f.ConfigPath 'init.lua') -Raw) -eq 'old config') 'Restore did not restore config.'
        Assert ((Get-Content -LiteralPath (Join-Path $f.DataPath 'old-data.txt') -Raw) -eq 'old data') 'Restore did not restore data.'
        $all = @(Get-Backups $f)
        Assert ($all.Count -eq 2) 'Restore should preserve its source backup and the replaced state.'
        Assert ((Get-Snapshot (Join-Path $all[-1].FullName 'config')) -eq $newConfig) 'Restore lost replaced config.'
        Assert ((Get-Snapshot (Join-Path $all[-1].FullName 'data')) -eq $newData) 'Restore lost replaced data.'
    }

    Test-Case 'Restore preserves originally absent destinations' {
        $f = New-Fixture 'restore-absent'
        & $installer @f | Out-Null
        $first = @(Get-Backups $f)[0]
        & $installer @f -Restore $first.FullName | Out-Null
        Assert (-not (Test-Path -LiteralPath $f.ConfigPath)) 'Config should be absent again.'
        Assert (-not (Test-Path -LiteralPath $f.DataPath)) 'Data should be absent again.'
        Assert (@(Get-Backups $f).Count -eq 2) 'The removed installation was not preserved.'
    }

    Test-Case 'WhatIf restore does not mutate installed state or backups' {
        $f = New-Fixture 'restore-whatif' -Existing
        & $installer @f | Out-Null
        $first = @(Get-Backups $f)[0]
        $root = Split-Path $f.SourcePath -Parent
        $before = Get-Snapshot $root
        & $installer @f -Restore $first.FullName -WhatIf | Out-Null
        Assert ((Get-Snapshot $root) -eq $before) 'WhatIf restore changed files.'
    }

    Test-Case 'Tampered backups are rejected before changing active config' {
        $f = New-Fixture 'tampered' -Existing
        & $installer @f | Out-Null
        $first = @(Get-Backups $f)[0]
        Write-Text (Join-Path $first.FullName 'config/init.lua') 'tampered'
        $before = Get-Snapshot $f.ConfigPath
        Assert-Rejected { & $installer @f -Restore $first.FullName } 'integrity check failed'
        Assert ((Get-Snapshot $f.ConfigPath) -eq $before) 'Tampered restore changed active config.'
    }

    Test-Case 'Backup manifest traversal and mismatched target paths are rejected' {
        $f = New-Fixture 'manifest' -Existing
        & $installer @f | Out-Null
        $first = @(Get-Backups $f)[0]
        $manifestPath = Join-Path $first.FullName 'manifest.json'
        $original = Get-Content -LiteralPath $manifestPath -Raw
        $manifest = $original | ConvertFrom-Json
        $manifest.ConfigFiles[0].Path = '../escape'
        Write-Text $manifestPath ($manifest | ConvertTo-Json -Depth 10)
        Assert-Rejected { & $installer @f -Restore $first.FullName } 'integrity check failed'
        $manifest = $original | ConvertFrom-Json
        $manifest.ConfigPath = Join-Path $testRoot 'other-target'
        Write-Text $manifestPath ($manifest | ConvertTo-Json -Depth 10)
        Assert-Rejected { & $installer @f -Restore $first.FullName } 'target paths do not match'
    }

    Test-Case 'Spaces and Unicode in every path work' {
        $f = New-Fixture ('spaces ' + [char]0x0442 + [char]0x0435 + [char]0x0441 + [char]0x0442)
        & $installer @f | Out-Null
        Assert (Test-Path -LiteralPath (Join-Path $f.ConfigPath 'init.lua')) 'Unicode install failed.'
    }

    Test-Case 'Overlapping and dangerous targets are rejected' {
        $f = New-Fixture 'overlap'
        $f.ConfigPath = Join-Path $f.PreparedDataPath 'inside'
        Assert-Rejected { & $installer @f } 'must not overlap'
        $f.ConfigPath = $repoRoot
        Assert-Rejected { & $installer @f } 'protected directory'
        $f.ConfigPath = [IO.Path]::GetPathRoot($repoRoot)
        Assert-Rejected { & $installer @f } 'filesystem root'
    }

    Test-Case 'Missing dependencies and source files fail without creating targets' {
        $f = New-Fixture 'missing'
        $f.PreparedDataPath = Join-Path $testRoot 'missing-data'
        Assert-Rejected { & $installer @f } 'does not exist'
        Assert (-not (Test-Path -LiteralPath $f.ConfigPath)) 'Failure created active config.'
        Assert (-not (Test-Path -LiteralPath $f.BackupRoot)) 'Failure created backup directory.'
    }

    Test-Case 'Reparse points in the source are rejected' {
        $f = New-Fixture 'junction'
        $junction = Join-Path $f.SourcePath 'linked'
        $null = New-Item -ItemType Junction -Path $junction -Target $f.PreparedDataPath
        try { Assert-Rejected { & $installer @f } 'Reparse points' }
        finally { [IO.Directory]::Delete($junction) }
        Assert (-not (Test-Path -LiteralPath $f.ConfigPath)) 'Junction failure created active config.'
    }

    Test-Case 'A failure moving data rolls back the already moved config' {
        $f = New-Fixture 'rollback' -Existing
        $oldConfig = Get-Snapshot $f.ConfigPath
        $oldData = Get-Snapshot $f.DataPath
        $lockedFile = [IO.File]::Open((Join-Path $f.DataPath 'old-data.txt'), [IO.FileMode]::Open, [IO.FileAccess]::Read, [IO.FileShare]::Read)
        try { Assert-Rejected { & $installer @f } 'previous config and data were restored' }
        finally { $lockedFile.Dispose() }
        Assert ((Get-Snapshot $f.ConfigPath) -eq $oldConfig) 'Rollback did not restore the original config.'
        Assert ((Get-Snapshot $f.DataPath) -eq $oldData) 'Rollback did not preserve the original data.'
        Assert (@(Get-Backups $f).Count -eq 0) 'Failed transaction left an incomplete backup.'
        $stages = @(Get-ChildItem -LiteralPath (Split-Path $f.ConfigPath -Parent) -Directory -Filter '.dotfiles-*')
        Assert ($stages.Count -eq 0) 'Failed transaction left staging directories.'
    }

    Write-Output "All $passed installer tests passed on PowerShell $($PSVersionTable.PSVersion)."
} finally {
    if (-not $KeepArtifacts) {
        $expectedParent = [IO.Path]::GetFullPath((Join-Path $repoRoot '.build'))
        if ([IO.Path]::GetDirectoryName($testRoot) -ne $expectedParent -or -not ([IO.Path]::GetFileName($testRoot).StartsWith('install-tests-'))) {
            throw "Refusing to clean unexpected test path: $testRoot"
        }
        Remove-Item -LiteralPath $testRoot -Recurse -Force
    } else { Write-Output "Fixtures: $testRoot" }
}
