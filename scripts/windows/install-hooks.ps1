[CmdletBinding()]
param(
    [string]$Repository
)

$ErrorActionPreference = 'Stop'
if (-not $Repository) { $Repository = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..')) }
$Repository = (Resolve-Path -LiteralPath $Repository).Path
$root = & git -C $Repository rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0) { throw 'The target is not a Git repository.' }
$Repository = (Resolve-Path -LiteralPath $root).Path
$current = & git -C $Repository config --get core.hooksPath
if ($LASTEXITCODE -notin @(0, 1)) { throw 'Could not inspect core.hooksPath.' }
if ($current -and $current -ne '.githooks') {
    throw "core.hooksPath is already '$current'. Review the existing hooks before changing it."
}
if (-not $current) {
    foreach ($name in @('pre-commit', 'commit-msg')) {
        $defaultHook = & git -C $Repository rev-parse --git-path "hooks/$name"
        if ($LASTEXITCODE -ne 0) { throw 'Could not inspect the existing hook directory.' }
        if (-not [System.IO.Path]::IsPathRooted($defaultHook)) { $defaultHook = Join-Path $Repository $defaultHook }
        if (Test-Path -LiteralPath $defaultHook -PathType Leaf) {
            throw "An existing $name hook would be bypassed. Review it before installing repository hooks."
        }
    }
}
foreach ($name in @('pre-commit', 'commit-msg')) {
    if (-not (Test-Path -LiteralPath (Join-Path $Repository ".githooks/$name") -PathType Leaf)) {
        throw "Missing repository hook: $name"
    }
}
& git -C $Repository config --local core.hooksPath .githooks
if ($LASTEXITCODE -ne 0) { throw 'Could not install the local hook setting.' }
Write-Output 'Local Git hooks use .githooks.'
