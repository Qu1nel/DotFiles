# Scripts

`windows/` contains PowerShell repository checks. `unix/` contains the earlier
shell/zsh utilities and `setup.sh`. `common/` contains the portable Python and Perl
utilities used by the older Unix setup.

Neovim setup is under `nvim/windows/setup.ps1`. The repository scripts serve these
purposes:

| Script | Purpose |
| --- | --- |
| `windows/check.ps1` | Offline source and commit-message checks |
| `windows/install-hooks.ps1` | Enable this clone's `.githooks` through local Git config |

From the repository root:

```powershell
.\scripts\windows\check.ps1
.\scripts\windows\install-hooks.ps1
```

Checks require Git, PowerShell 5.1 or 7 and Neovim on PATH; use `-NvimPath` for
a specific executable. Lua is parsed without loading the configuration. Checks
cover PowerShell/JSON syntax, whitespace, conflict markers, private-key headers
and known local/generated paths. YAML/TOML schemas are outside these checks.

Pre-commit runs `check.ps1 -Staged` against Git's staged blobs: an unstaged fix
cannot hide an error in the commit. Commit-msg checks a Conventional Commits
header within 72 ASCII characters and rejects assistant attribution. Use short
English messages describing the change, for example:

```text
fix(nvim): preserve modified buffers
feat(nvim): add Python type checking
refactor: organize platform scripts
```

Wording and file selection still need review. Stage named files or use `git add -p`
and inspect `git diff --cached`. Local agent instructions, caches, backups and logs
stay outside Git. Hook setup refuses to bypass an existing different hook path or
default commit hooks. See [test commands](../tests/README.md).
