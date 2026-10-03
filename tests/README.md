# Tests

`nvim/` contains Lua integration checks run inside the actual editor. They cover
the explorer, mappings, unsaved buffers, explicit formatting, diagnostics appearing
and clearing, and Python completion. They test editor behavior, but currently use
the Windows profile and tools. Unix compatibility has not been validated.

`windows/` contains PowerShell tests using disposable directories and Git
repositories. They do not replace the active profile.

| Test | What it verifies |
| --- | --- |
| `workflow.Tests.ps1` | Source checks, real hooks, staged blobs and commit messages |
| `install.Tests.ps1` | Repeat install, protected edits, backup/restore, rollback and paths |
| `setup.Tests.ps1` | Damaged archives, cache integrity, prerequisites, launcher and unsafe paths |

Run from the repository root with Git and Neovim available:

```powershell
.\scripts\windows\check.ps1
.\tests\windows\workflow.Tests.ps1
.\tests\windows\install.Tests.ps1
.\tests\windows\setup.Tests.ps1
```

For execution-policy restrictions use
`powershell -NoProfile -ExecutionPolicy Bypass -File <script-path>`.
Run the same commands in PowerShell 7 (`pwsh`) to check both supported shells.

To prepare pinned dependencies and run the editor checks:

```powershell
.\nvim\windows\setup.ps1 -PrepareOnly -Root "$PWD\.build\nvim-prepared"
```

Preparation invokes `nvim/runner.lua` with `smoke.lua` and `languages.lua`;
`buffer-picker.lua` is included by smoke. First preparation needs internet; repeats
verify cached files. Preparation leaves the active profile and persistent PATH
unchanged. Missing Microsoft runtime is reported; `-InstallVCRuntime` explicitly
allows its installation.

Output is under ignored `.build/` or temporary profile directories. The GitHub
Windows workflow runs these checks in PowerShell 5.1 and 7. Headless checks do
not verify appearance, clipboard or keys intercepted by the terminal; open real
files after deployment.
