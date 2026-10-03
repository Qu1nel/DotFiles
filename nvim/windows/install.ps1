[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [string] $SourcePath = (Join-Path $PSScriptRoot 'config'),
    [string] $PreparedDataPath,
    [string] $ConfigPath = (Join-Path $env:LOCALAPPDATA 'nvim'),
    [string] $DataPath = (Join-Path $env:LOCALAPPDATA 'nvim-data'),
    [string] $BackupRoot = (Join-Path $env:LOCALAPPDATA 'DotFiles/backups/nvim'),
    [string] $Restore,
    [switch] $Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$markerName = '.dotfiles-install.json'
$pathComparison = [StringComparison]::OrdinalIgnoreCase

function Get-FullPath([string] $Path) {
    if ([string]::IsNullOrWhiteSpace($Path)) { throw 'A nonempty filesystem path is required.' }
    if (-not [IO.Path]::IsPathRooted($Path)) { $Path = Join-Path $PWD.ProviderPath $Path }
    return [IO.Path]::GetFullPath($Path).TrimEnd('\', '/')
}

function Test-InPath([string] $Path, [string] $Parent) {
    return $Path.Equals($Parent, $pathComparison) -or $Path.StartsWith($Parent + [IO.Path]::DirectorySeparatorChar, $pathComparison)
}

function Assert-PhysicalDirectory([string] $Path) {
    if (-not ('DotFilesWindowsInstallerPathsV1' -as [type])) {
        Add-Type -TypeDefinition @'
using System;
using System.ComponentModel;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using Microsoft.Win32.SafeHandles;

public static class DotFilesWindowsInstallerPathsV1 {
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true, ExactSpelling = true)]
    private static extern SafeFileHandle CreateFileW(string path, uint access, uint share,
        IntPtr security, uint disposition, uint flags, IntPtr template);
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true, ExactSpelling = true)]
    private static extern uint GetFinalPathNameByHandleW(SafeFileHandle handle,
        StringBuilder path, uint capacity, uint flags);

    public static string Resolve(string path) {
        using (SafeFileHandle handle = CreateFileW(path, 0, 7, IntPtr.Zero, 3, 0x02000000, IntPtr.Zero)) {
            if (handle.IsInvalid) throw new Win32Exception(Marshal.GetLastWin32Error());
            StringBuilder result = new StringBuilder(32768);
            uint length = GetFinalPathNameByHandleW(handle, result, (uint)result.Capacity, 0);
            if (length == 0) throw new Win32Exception(Marshal.GetLastWin32Error());
            if (length >= result.Capacity) throw new IOException("Physical directory path is too long.");
            return result.ToString();
        }
    }
}
'@
    }
    $requested = Get-FullPath $Path
    $physical = [DotFilesWindowsInstallerPathsV1]::Resolve($requested)
    if ($physical.StartsWith('\\?\UNC\', $pathComparison)) { $physical = '\\' + $physical.Substring(8) }
    elseif ($physical.StartsWith('\\?\', $pathComparison)) { $physical = $physical.Substring(4) }
    $physical = Get-FullPath $physical
    if (-not $physical.Equals($requested, $pathComparison)) {
        throw "AppData redirected by packaged host, rerun in ordinary PowerShell. Requested: $requested. Physical: $physical"
    }
}

function Assert-PlainDirectory([string] $Path, [switch] $Required) {
    $cursor = $Path
    while (-not [string]::IsNullOrEmpty($cursor)) {
        if (Test-Path -LiteralPath $cursor) {
            $item = Get-Item -LiteralPath $cursor -Force
            if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
                throw "Reparse points are not supported: $cursor"
            }
            if (-not $item.PSIsContainer) { throw "Expected a directory: $cursor" }
        }
        $parent = [IO.Path]::GetDirectoryName($cursor)
        if ($parent -eq $cursor) { break }
        $cursor = $parent
    }
    if (-not (Test-Path -LiteralPath $Path)) {
        if ($Required) { throw "Directory does not exist: $Path" }
        return
    }
    $pending = [Collections.Generic.Queue[string]]::new()
    $pending.Enqueue($Path)
    while ($pending.Count -gt 0) {
        foreach ($item in Get-ChildItem -LiteralPath $pending.Dequeue() -Force) {
            if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
                throw "Reparse points are not supported: $($item.FullName)"
            }
            if ($item.PSIsContainer) { $pending.Enqueue($item.FullName) }
        }
    }
}

function Assert-SafeTarget([string] $Path) {
    $root = [IO.Path]::GetPathRoot($Path).TrimEnd('\', '/')
    if ($Path -eq $root) { throw "A filesystem root cannot be a target: $Path" }
    $protectedPaths = @($env:USERPROFILE, $env:LOCALAPPDATA, $env:APPDATA, $env:WINDIR, $env:ProgramFiles,
        [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..')))
    foreach ($protected in $protectedPaths) {
        if ($protected -and (Test-InPath (Get-FullPath $protected) $Path)) {
            throw "The target contains a protected directory: $Path"
        }
    }
    Assert-PlainDirectory $Path
}

function Assert-SeparatePaths([string[]] $Paths) {
    for ($i = 0; $i -lt $Paths.Count; $i++) {
        for ($j = $i + 1; $j -lt $Paths.Count; $j++) {
            if ((Test-InPath $Paths[$i] $Paths[$j]) -or (Test-InPath $Paths[$j] $Paths[$i])) {
                throw "Paths must not overlap: $($Paths[$i]) and $($Paths[$j])"
            }
        }
    }
}

function Test-RuntimeDataPath([string] $Path) {
    return $Path -match '^(shada|swap|undo|backup|view|logs|state|cache)(/|$)|^(log|nvim\.log|lsp\.log|lazy-state\.json)$'
}

function Get-Tree([string] $Path, [switch] $ManagedData, [switch] $ExcludeMarker) {
    Assert-PlainDirectory $Path -Required
    foreach ($item in (Get-ChildItem -LiteralPath $Path -Recurse -Force | Sort-Object FullName)) {
        $relative = $item.FullName.Substring($Path.Length + 1).Replace('\', '/')
        if ($ExcludeMarker -and $relative -eq $markerName) { continue }
        if ($ManagedData -and ((Test-RuntimeDataPath $relative) -or $relative -match '(^|/)\.git(/|$)' -or $relative -match '(^|/)doc/tags$')) { continue }
        if ($item.PSIsContainer) {
            [pscustomobject][ordered]@{ Path = $relative; Type = 'directory'; Hash = ''; Length = 0 }
        } else {
            [pscustomobject][ordered]@{
                Path = $relative; Type = 'file'
                Hash = (Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash
                Length = $item.Length
            }
        }
    }
}

function Test-TreesEqual([object[]] $Expected, [object[]] $Actual) {
    if ($Expected.Count -ne $Actual.Count) { return $false }
    $lookup = @{}
    foreach ($entry in $Actual) {
        if ($lookup.ContainsKey($entry.Path)) { return $false }
        $lookup[$entry.Path] = $entry
    }
    $seen = @{}
    foreach ($entry in $Expected) {
        if ([string]::IsNullOrWhiteSpace($entry.Path) -or $entry.Path -match '(^|/)\.\.(/|$)|\\|^/|:' -or $seen.ContainsKey($entry.Path)) { return $false }
        $seen[$entry.Path] = $true
        if (-not $lookup.ContainsKey($entry.Path)) { return $false }
        $other = $lookup[$entry.Path]
        if ($entry.Type -ne $other.Type -or $entry.Hash -ne $other.Hash -or $entry.Length -ne $other.Length) { return $false }
    }
    return $true
}

function Write-Json([string] $Path, [object] $Value) {
    [IO.File]::WriteAllText($Path, ($Value | ConvertTo-Json -Depth 10), [Text.UTF8Encoding]::new($false))
}

function Read-Json([string] $Path) {
    return ([IO.File]::ReadAllText($Path) | ConvertFrom-Json)
}

function Assert-PluginCommits([string] $Path, [object] $PluginLock) {
    foreach ($plugin in $PluginLock.PSObject.Properties) {
        if ($plugin.Name -notmatch '^[a-zA-Z0-9_.-]+$' -or $plugin.Name -in @('.', '..') -or $plugin.Value.commit -notmatch '^[a-fA-F0-9]{40}$') {
            throw 'Invalid plugin lock entry.'
        }
        $gitPath = Join-Path $Path ('lazy/' + $plugin.Name + '/.git')
        $head = [IO.File]::ReadAllText((Join-Path $gitPath 'HEAD')).Trim()
        if ($head.StartsWith('ref: ')) {
            $reference = $head.Substring(5)
            if ($reference -notmatch '^refs/[a-zA-Z0-9_./-]+$' -or $reference -match '(^|/)\.\.(/|$)') {
                throw "Invalid Git reference for plugin $($plugin.Name)."
            }
            $referencePath = Join-Path $gitPath $reference
            if (Test-Path -LiteralPath $referencePath -PathType Leaf) {
                $head = [IO.File]::ReadAllText($referencePath).Trim()
            } else {
                $packed = [IO.File]::ReadAllLines((Join-Path $gitPath 'packed-refs'))
                $matchesForRef = @($packed | Where-Object { $_ -match ('^[a-fA-F0-9]{40} ' + [regex]::Escape($reference) + '$') })
                if ($matchesForRef.Count -ne 1) { throw "Cannot resolve plugin reference: $($plugin.Name)." }
                $head = $matchesForRef[0].Substring(0, 40)
            }
        }
        if ($head -ne $plugin.Value.commit) { throw "Plugin commit does not match lazy-lock.json: $($plugin.Name)." }
    }
}

function Assert-PreparedBundle([string] $Path, [string] $Source) {
    $descriptor = Read-Json (Join-Path $Path 'dotfiles-runtime.json')
    $runtimeLockPath = Join-Path $PSScriptRoot 'runtime-lock.json'
    $runtimeLock = Read-Json $runtimeLockPath
    if ($descriptor.schema_version -ne 1 -or [string]::IsNullOrWhiteSpace($descriptor.nvim_version)) { throw 'Unsupported prepared bundle descriptor.' }
    if ($descriptor.runtime_lock_sha256 -ne (Get-FileHash -LiteralPath $runtimeLockPath -Algorithm SHA256).Hash) {
        throw 'Prepared bundle does not match runtime-lock.json.'
    }
    if ($descriptor.nvim_version.TrimStart('v') -ne $runtimeLock.downloads.neovim.version.TrimStart('v')) {
        throw 'Prepared bundle Neovim version does not match runtime-lock.json.'
    }
    $pluginLockPath = Join-Path $Source 'lazy-lock.json'
    if ($descriptor.plugin_lock_sha256 -ne (Get-FileHash -LiteralPath $pluginLockPath -Algorithm SHA256).Hash) {
        throw 'Prepared bundle does not match the source lazy-lock.json.'
    }
    $required = @('lazy/lazy.nvim/lua/lazy/init.lua', 'tools/bin/ruff.exe', 'tools/bin/gopls.exe', 'tools/bin/taplo.exe', 'tools/bin/rg.exe')
    if (@($descriptor.required_files).Count -eq 0) { throw 'Prepared bundle must list required_files.' }
    foreach ($relative in @($required + @($descriptor.required_files))) {
        if ($relative -isnot [string] -or [string]::IsNullOrWhiteSpace($relative) -or $relative -match '(^|/)\.\.?(/|$)|\\|^/|:') {
            throw 'Invalid prepared bundle file path.'
        }
        if (-not (Test-Path -LiteralPath (Join-Path $Path $relative) -PathType Leaf)) { throw "Prepared bundle is missing a required file: $relative" }
    }
    $pluginLock = Read-Json $pluginLockPath
    $expectedPlugins = @($runtimeLock.plugins.PSObject.Properties)
    if (@($pluginLock.PSObject.Properties).Count -ne $expectedPlugins.Count) { throw 'Plugin lock does not match runtime-lock.json.' }
    foreach ($plugin in $expectedPlugins) {
        $locked = $pluginLock.PSObject.Properties[$plugin.Name]
        if ($null -eq $locked -or $locked.Value.commit -ne $plugin.Value.commit) { throw 'Plugin lock does not match runtime-lock.json.' }
    }
    Assert-PluginCommits $Path $pluginLock
    return $pluginLock
}

function Assert-DirectChild([string] $Path, [string] $Parent) {
    $absolute = Get-FullPath $Path
    if (-not ([IO.Path]::GetDirectoryName($absolute).Equals((Get-FullPath $Parent), $pathComparison))) {
        throw "Operation escaped its expected parent: $absolute"
    }
    Assert-SafeTarget $absolute
}

function Remove-Stage([string] $Path, [string] $Parent) {
    Assert-DirectChild $Path $Parent
    if (Test-Path -LiteralPath $Path) { Remove-Item -LiteralPath $Path -Recurse -Force }
}

function Move-Directory([string] $From, [string] $To) {
    Assert-SafeTarget $From
    Assert-SafeTarget $To
    Assert-PhysicalDirectory $From
    Assert-PhysicalDirectory ([IO.Path]::GetDirectoryName($To))
    if (Test-Path -LiteralPath $To) { throw "Move destination already exists: $To" }
    Move-Item -LiteralPath $From -Destination $To
}

function Copy-Tree([string] $From, [string] $To) {
    Assert-PlainDirectory $From -Required
    Assert-SafeTarget $To
    if (Test-Path -LiteralPath $To) { throw "Stage already exists: $To" }
    $null = New-Item -ItemType Directory -Path $To
    Assert-PhysicalDirectory $To
    foreach ($item in Get-ChildItem -LiteralPath $From -Force) {
        Copy-Item -LiteralPath $item.FullName -Destination $To -Recurse -Force
    }
    if (-not (Test-TreesEqual @(Get-Tree $From) @(Get-Tree $To))) { throw "Staging verification failed: $To" }
}

function Read-Backup([string] $Path) {
    Assert-DirectChild $Path $BackupRoot
    Assert-PlainDirectory $Path -Required
    $manifest = Read-Json (Join-Path $Path 'manifest.json')
    if ($manifest.Version -ne 1 -or $manifest.HasConfig -isnot [bool] -or $manifest.HasData -isnot [bool]) {
        throw "Unsupported backup manifest: $Path"
    }
    if (-not (Get-FullPath $manifest.ConfigPath).Equals($ConfigPath, $pathComparison) -or
        -not (Get-FullPath $manifest.DataPath).Equals($DataPath, $pathComparison)) {
        throw 'Backup target paths do not match ConfigPath and DataPath.'
    }
    foreach ($part in @('Config', 'Data')) {
        $folder = Join-Path $Path $part.ToLowerInvariant()
        $present = $manifest.('Has' + $part)
        $expected = @($manifest.($part + 'Files'))
        if ($present) {
            if (-not (Test-TreesEqual $expected @(Get-Tree $folder))) { throw "Backup integrity check failed: $folder" }
        } elseif ((Test-Path -LiteralPath $folder) -or $expected.Count -ne 0) {
            throw "Backup absence record is invalid: $folder"
        }
    }
    $allowed = @('manifest.json')
    if ($manifest.HasConfig) { $allowed += 'config' }
    if ($manifest.HasData) { $allowed += 'data' }
    foreach ($item in Get-ChildItem -LiteralPath $Path -Force) {
        if ($item.Name -notin $allowed) { throw "Unexpected backup content: $($item.FullName)" }
    }
    return $manifest
}

$ConfigPath = Get-FullPath $ConfigPath
$DataPath = Get-FullPath $DataPath
$BackupRoot = Get-FullPath $BackupRoot
foreach ($target in @($ConfigPath, $DataPath, $BackupRoot)) {
    Assert-SafeTarget $target
    if (Test-Path -LiteralPath $target) { Assert-PhysicalDirectory $target }
}
Assert-SeparatePaths @($ConfigPath, $DataPath, $BackupRoot)
foreach ($target in @($ConfigPath, $DataPath)) {
    if ([IO.Path]::GetPathRoot($target) -ne [IO.Path]::GetPathRoot($BackupRoot)) {
        throw 'ConfigPath, DataPath and BackupRoot must be on the same volume.'
    }
}

$wantConfig = $true
$wantData = $true
$configSource = $null
$dataSource = $null
$receipt = $null
if ($Restore) {
    $Restore = Get-FullPath $Restore
    $backup = Read-Backup $Restore
    $wantConfig = $backup.HasConfig
    $wantData = $backup.HasData
    if ($wantConfig) { $configSource = Join-Path $Restore 'config' }
    if ($wantData) { $dataSource = Join-Path $Restore 'data' }
    $action = "Restore config and data from $Restore"
} else {
    $SourcePath = Get-FullPath $SourcePath
    $PreparedDataPath = Get-FullPath $PreparedDataPath
    Assert-SeparatePaths @($SourcePath, $PreparedDataPath, $ConfigPath, $DataPath, $BackupRoot)
    Assert-PlainDirectory $SourcePath -Required
    Assert-PlainDirectory $PreparedDataPath -Required
    if (-not (Test-Path -LiteralPath (Join-Path $SourcePath 'init.lua') -PathType Leaf)) { throw 'SourcePath must contain init.lua.' }
    if (-not (Test-Path -LiteralPath (Join-Path $SourcePath 'lazy-lock.json') -PathType Leaf)) { throw 'SourcePath must contain lazy-lock.json.' }
    if (Test-Path -LiteralPath (Join-Path $SourcePath $markerName)) { throw "SourcePath must not contain $markerName." }
    $pluginLock = Assert-PreparedBundle $PreparedDataPath $SourcePath
    $sourceFiles = @(Get-Tree $SourcePath)
    $preparedFiles = @(Get-Tree $PreparedDataPath -ManagedData)
    $receipt = [ordered]@{ Version = 1; ConfigFiles = $sourceFiles; DataFiles = $preparedFiles }
    $markerPath = Join-Path $ConfigPath $markerName
    if (Test-Path -LiteralPath $markerPath) {
        $installed = Read-Json $markerPath
        if ($installed.Version -ne 1) { throw 'Unsupported installation receipt.' }
        $installedDataFiles = @($installed.DataFiles | Where-Object { -not (Test-RuntimeDataPath $_.Path) })
        $configClean = Test-TreesEqual @($installed.ConfigFiles) @(Get-Tree $ConfigPath -ExcludeMarker)
        $dataClean = (Test-Path -LiteralPath $DataPath) -and (Test-TreesEqual $installedDataFiles @(Get-Tree $DataPath -ManagedData))
        if ($dataClean) {
            try { Assert-PluginCommits $DataPath (Read-Json (Join-Path $ConfigPath 'lazy-lock.json')) }
            catch { $dataClean = $false }
        }
        if ((-not $configClean -or -not $dataClean) -and -not $Force) {
            throw 'Installed config or managed data has changed. Use -Force to replace it after making a backup.'
        }
        if ($configClean -and $dataClean -and
            (Test-TreesEqual $sourceFiles @($installed.ConfigFiles)) -and
            (Test-TreesEqual $preparedFiles $installedDataFiles)) {
            Write-Output 'Already installed; no files changed.'
            return
        }
    }
    $configSource = $SourcePath
    $dataSource = $PreparedDataPath
    $action = 'Install prepared config and data'
}

if (-not $PSCmdlet.ShouldProcess("$ConfigPath and $DataPath", $action)) { return }

$transactionId = [DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfffZ') + '-' + [Guid]::NewGuid().ToString('N')
$configParent = [IO.Path]::GetDirectoryName($ConfigPath)
$dataParent = [IO.Path]::GetDirectoryName($DataPath)
$configStage = Join-Path $configParent ('.dotfiles-config-' + $transactionId)
$dataStage = Join-Path $dataParent ('.dotfiles-data-' + $transactionId)
$backupPath = Join-Path $BackupRoot $transactionId
Assert-DirectChild $configStage $configParent
Assert-DirectChild $dataStage $dataParent
Assert-DirectChild $backupPath $BackupRoot
$lock = $null
$movedConfig = $false
$movedData = $false
$activatedConfig = $false
$activatedData = $false
$rollbackComplete = $false
try {
    foreach ($directory in @($configParent, $dataParent, $BackupRoot)) {
        if (-not (Test-Path -LiteralPath $directory)) { $null = New-Item -ItemType Directory -Path $directory -Force }
    }
    Assert-PhysicalDirectory $BackupRoot
    $lock = [IO.File]::Open((Join-Path $BackupRoot '.install.lock'), [IO.FileMode]::OpenOrCreate, [IO.FileAccess]::ReadWrite, [IO.FileShare]::None)
    if ($wantConfig) { Copy-Tree $configSource $configStage }
    if ($wantData) { Copy-Tree $dataSource $dataStage }
    if ($receipt) { Write-Json (Join-Path $configStage $markerName) $receipt }
    $oldConfig = Test-Path -LiteralPath $ConfigPath
    $oldData = Test-Path -LiteralPath $DataPath
    $oldConfigFiles = @()
    $oldDataFiles = @()
    if ($oldConfig) { $oldConfigFiles = @(Get-Tree $ConfigPath) }
    if ($oldData) { $oldDataFiles = @(Get-Tree $DataPath) }
    $manifest = [ordered]@{
        Version = 1; CreatedUtc = [DateTime]::UtcNow.ToString('o')
        ConfigPath = $ConfigPath; DataPath = $DataPath
        HasConfig = [bool]$oldConfig; HasData = [bool]$oldData
        ConfigFiles = $oldConfigFiles; DataFiles = $oldDataFiles
    }
    $null = New-Item -ItemType Directory -Path $backupPath
    Assert-PhysicalDirectory $backupPath
    Write-Json (Join-Path $backupPath 'manifest.json') $manifest
    if ($oldConfig) { Move-Directory $ConfigPath (Join-Path $backupPath 'config'); $movedConfig = $true }
    if ($oldData) { Move-Directory $DataPath (Join-Path $backupPath 'data'); $movedData = $true }
    $null = Read-Backup $backupPath
    if ($wantConfig) { Move-Directory $configStage $ConfigPath; $activatedConfig = $true }
    if ($wantData) { Move-Directory $dataStage $DataPath; $activatedData = $true }
    Write-Output "Completed. Backup: $backupPath"
} catch {
    $failure = $_
    try {
        if ($activatedData) { Move-Directory $DataPath $dataStage }
        if ($activatedConfig) { Move-Directory $ConfigPath $configStage }
        if ($movedData) { Move-Directory (Join-Path $backupPath 'data') $DataPath }
        if ($movedConfig) { Move-Directory (Join-Path $backupPath 'config') $ConfigPath }
        $rollbackComplete = $true
    } catch {
        throw "Installation failed: $($failure.Exception.Message). Rollback also failed: $($_.Exception.Message). Preserved recovery files at $backupPath, $configStage and $dataStage."
    }
    throw "Installation failed; previous config and data were restored. $($failure.Exception.Message)"
} finally {
    if ($lock) { $lock.Dispose() }
    if ($rollbackComplete) {
        Remove-Stage $configStage $configParent
        Remove-Stage $dataStage $dataParent
        if (Test-Path -LiteralPath $backupPath) { Remove-Stage $backupPath $BackupRoot }
    }
}
