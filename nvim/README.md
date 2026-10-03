# Neovim

The maintained profile targets Windows 11 x64 and Neovim 0.12.5 or newer. It
provides a tree on the left, AstroNvim navigation habits, syntax highlighting,
language diagnostics and native completion. Format explicitly with `Space lf`.

```text
nvim/
  legacy/
    astro-v4/             Previous AstroNvim configuration
    astro-old/            Earlier configuration
  windows/
    config/               init.lua, Lua modules and lazy-lock.json
    setup.ps1             Download, prepare, test and deploy
    install.ps1           Deploy or restore a prepared profile
    runtime-lock.json     Versions, download URLs, hashes and plugin commits
    tools/                npm package.json and package-lock.json
```

Legacy configurations are preserved for reference. A maintained Unix profile
can later live in `nvim/unix` with its own installer.

## New Windows installation

Clone this repository or extract its ZIP, then open a normal PowerShell window
in the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\nvim\windows\setup.ps1 -InstallVCRuntime -AddToPath
```

Scoop, winget, an existing Git, Node, Go or Python installation are not required.
Setup downloads pinned official archives, checks SHA-256 hashes, installs locked
npm dependencies without lifecycle scripts, builds gopls and fetches exact plugin
commits. It tests a separate profile before replacing yours. First preparation
needs internet and disk space for tools, the Go SDK, caches and backups.

`-InstallVCRuntime` permits installing Microsoft's Visual C++ x64 runtime when
missing. Its hash and Microsoft signature are verified; Windows may request
administrator approval. A required restart stops setup before deployment. The
editor and tools otherwise install under your user account. See
[Microsoft's runtime deployment guidance](https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170).
`-ExecutionPolicy Bypass` applies to this PowerShell process.

Open a new terminal and run `nvim`. The launcher is
`%LOCALAPPDATA%\DotFiles\nvim\bin\nvim.cmd`.

## Existing Neovim and preparation

Update an existing Neovim through its package manager first, then run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\nvim\windows\setup.ps1 -NeovimPath nvim
```

This uses the existing executable. `-AddToPath` refuses to shadow another Neovim.
Packaged editor hosts can redirect AppData; the installer rejects redirected paths
before moving the profile. Use a normal PowerShell window.

`-WhatIf` gives a dry run. Prepare and test without deploying with:

```powershell
.\nvim\windows\setup.ps1 -PrepareOnly -Root "$PWD\.build\nvim-prepared"
```

This keeps the active profile and persistent PATH unchanged. Combining it with
`-InstallVCRuntime` explicitly permits the system prerequisite installation.

## Files and dependencies

| Location | Contents |
| --- | --- |
| `%LOCALAPPDATA%\nvim` | Installed configuration |
| `%LOCALAPPDATA%\nvim-data` | Plugins, private language tools and editor state |
| `%LOCALAPPDATA%\DotFiles\nvim` | Downloads, build cache, prepared releases and launcher |
| `%LOCALAPPDATA%\DotFiles\backups\nvim` | Previous config and data bundles |

`setup.ps1` is the entry point: it downloads dependencies and runs editor checks,
then calls `install.ps1`. The latter handles backup, deployment, repeat installation
and restore without downloading anything. Normally run only setup.

Keep lockfiles in Git: they define what a new machine installs.
`runtime-lock.json` covers binaries and plugin commits; `config/lazy-lock.json`
is Lazy's plugin lock; `tools/package-lock.json` fixes npm dependencies and integrity
hashes. The repository's `tools/` contains manifests, not executables. Installed
tools live under `nvim-data/tools`.

| Files | Diagnostics and completion | Explicit formatter |
| --- | --- | --- |
| Python | Ruff linting; Pyright types, navigation and completion | Ruff |
| Go | gopls with a private Go SDK | gopls |
| YAML | YAML language server | YAML language server |
| TOML | Taplo | Taplo |
| Markdown | markdownlint-cli2 | Not included |

Pyright uses basic type checking for open files, including errors such as
`print(3 + "34")`. Project configuration and virtual environments refine analysis.
Install Python itself when you need to run programs. Go needs a valid module for
project diagnostics. YAML schema-store downloads are disabled. Highlighting uses
Neovim's built-in syntax rules.

## Controls

Leader is Space. Completion appears while typing supported code; `Ctrl-Space`
requests it, `Ctrl-n`/`Ctrl-p` select, `Ctrl-y` accepts and `Ctrl-e` dismisses.
Use `:checkhealth dotfiles` to inspect tools.

| Keys | Action |
| --- | --- |
| `kj` | Leave insert mode |
| `Ctrl-s`, `Space w` | Save |
| `Space q`, `Space x` | Save and quit the window |
| `Tab`, `Shift-Tab` | Next/previous buffer; accepts a count |
| `Space j`, `Space fb` | Pick a buffer |
| `Space c`, `Space C` | Close / explicitly discard changes |
| `Space bc`, `Space bC`, `Space bD` | Pick buffer to close / close all / all except current |
| `Space bv`, `Space bh`, `Space bs` | Pick buffer for vertical/horizontal split |
| `Space bn` | New tab |
| `Ctrl-h/j/k/l` | Move between windows |
| `gk`, `gj`, `H`, `L`, `gh` | First/last line, start/end of line, first nonblank |
| `Space e`, `Space o` | Toggle/focus the tree on the left |
| `Space ff`, `Space fw`, `Space fh` | Find files / search text / help |
| `F2` | Focus the current window / restore layout |
| `gl`, `[d`, `]d` | Show / previous / next diagnostic |
| `Space ld`, `Space lD` | Buffer/workspace diagnostics |
| `Space lf`, `:Format` | Format explicitly |
| `K`, `gd`, `gD`, `gr` | Hover/definition/declaration/references when supported |
| `Space la`, `Space lr` | Code action / rename when supported |
| `gc`, `gcc` | Comment operator / toggle line comment |

Ordinary buffer close preserves unsaved work. The Russian keyboard mapping is
retained. Icons do not need a patched font.

## Update and restore

Edit `windows/config`, test, then rerun setup. An identical install is a no-op.
Local edits to installed config or tools are protected; copy useful changes back
into Git. `-Force` replaces those edits with a backup. A changed installation starts
with prepared editor state; previous undo/history files remain in the old bundle.

Close Neovim before installing or restoring. Restore the backup printed by the
installer with:

```powershell
.\nvim\windows\install.ps1 -Restore "$env:LOCALAPPDATA\DotFiles\backups\nvim\<backup-folder>"
```

Restore checks hashes and backs up the profile it replaces. Config/data/backups
must share a volume; junctions and symlinks are rejected. Scoop manages its binary
separately; the shared Microsoft runtime is outside profile restore. A late
launcher/PATH failure is reported separately after profile installation.

Update locks deliberately and test before deployment. `:Lazy update` modifies
installed files outside this process and is detected at reinstall.
See [test commands](../tests/README.md) and [repository checks](../scripts/README.md).
