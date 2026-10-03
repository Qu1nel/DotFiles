local M = {}
M.servers = {
  ruff = { command = "ruff", args = { "server" } },
  pyright = { command = "pyright-langserver", args = { "--stdio" } },
  gopls = { command = "gopls", args = {} },
  yamlls = { command = "yaml-language-server", args = { "--stdio" } },
  taplo = { command = "taplo", args = { "lsp", "stdio" } },
}

function M.command(name, args)
  local root = vim.env.DOTFILES_NVIM_TOOLS or (vim.fn.stdpath("data") .. "/tools")
  local npm_scripts = {
    ["yaml-language-server"] = "yaml-language-server/bin/yaml-language-server",
    ["markdownlint-cli2"] = "markdownlint-cli2/markdownlint-cli2-bin.mjs",
    ["pyright-langserver"] = "pyright/langserver.index.js",
  }
  local script = npm_scripts[name] and (root .. "/npm/node_modules/" .. npm_scripts[name])
  if script and vim.uv.fs_stat(script) then
    local node = vim.fn.exepath("node")
    if node == "" then return nil end
    local command = { node, script }
    vim.list_extend(command, args or {})
    return command
  end
  local path = vim.fn.exepath(name)
  if path == "" then return nil end
  local command = { path }
  vim.list_extend(command, args or {})
  if vim.fn.has("win32") == 1 and path:lower():match("%.[bc][am][td]$") then
    command = { vim.env.COMSPEC or "cmd.exe", "/d", "/c", path }
    vim.list_extend(command, args or {})
  end
  return command
end

function M.setup_lsp()
  vim.diagnostic.config({
    virtual_text = { spacing = 2, severity = { min = vim.diagnostic.severity.WARN } },
    signs = { text = { [vim.diagnostic.severity.ERROR] = "E", [vim.diagnostic.severity.WARN] = "W", [vim.diagnostic.severity.INFO] = "I", [vim.diagnostic.severity.HINT] = "H" } },
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    float = { border = "rounded", source = true },
  })
  for name, spec in pairs(M.servers) do
    local command = M.command(spec.command, spec.args)
    if command then
      local settings = {}
      if name == "yamlls" then
        settings = { yaml = { keyOrdering = false, schemaStore = { enable = false } }, redhat = { telemetry = { enabled = false } } }
      elseif name == "pyright" then
        settings = {
          pyright = { disableOrganizeImports = true },
          python = { analysis = { typeCheckingMode = "basic", diagnosticMode = "openFilesOnly", autoImportCompletions = true } },
        }
      end
      local environment = { PATH = vim.env.PATH }
      local tools_root = vim.env.DOTFILES_NVIM_TOOLS or (vim.fn.stdpath("data") .. "/tools")
      if name == "gopls" and vim.uv.fs_stat(tools_root .. "/go/bin/go.exe") then
        environment.GOROOT = tools_root .. "/go"
        environment.GOTOOLCHAIN = "local"
      end
      -- Windows can expose an older PATH through environ() after setenv().
      -- Pass the effective search path to servers that spawn their own tools.
      vim.lsp.config(name, { cmd = command, cmd_env = environment, settings = settings })
      vim.lsp.enable(name)
    end
  end
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("DotfilesLsp", { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then return end
      if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
      local function map(lhs, rhs, desc, method)
        if not method or client:supports_method(method, event.buf) then
          vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
        end
      end
      map("K", vim.lsp.buf.hover, "Hover documentation", "textDocument/hover")
      map("gD", vim.lsp.buf.declaration, "Go to declaration", "textDocument/declaration")
      map("gd", vim.lsp.buf.definition, "Go to definition", "textDocument/definition")
      map("gr", vim.lsp.buf.references, "Find references", "textDocument/references")
      map("<Leader>la", vim.lsp.buf.code_action, "Code action", "textDocument/codeAction")
      map("<Leader>lr", vim.lsp.buf.rename, "Rename symbol", "textDocument/rename")
      if client:supports_method("textDocument/completion", event.buf) then
        vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local provider = client.server_capabilities.completionProvider
        local triggers = provider.triggerCharacters or {}
        for character in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"):gmatch(".") do
          if not vim.list_contains(triggers, character) then triggers[#triggers + 1] = character end
        end
        provider.triggerCharacters = triggers
        vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { buffer = event.buf, silent = true, desc = "Request completion" })
      end
    end,
  })
end

function M.setup_lint()
  local lint = require("lint")
  local command = M.command("markdownlint-cli2", { "-" })
  if not command then return end
  local definition = lint.linters["markdownlint-cli2"]
  definition.cmd = command[1]
  definition.args = vim.list_slice(command, 2)
  lint.linters_by_ft = { markdown = { "markdownlint-cli2" } }
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("DotfilesLint", { clear = true }),
    callback = function(event)
      if vim.bo[event.buf].buftype == "" and vim.bo[event.buf].filetype == "markdown" then
        lint.try_lint()
      end
    end,
  })
end

function M.format()
  local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" })
  if #clients == 0 then
    vim.notify("No formatter is attached to this buffer. Check :checkhealth dotfiles.", vim.log.levels.WARN)
    return false
  end
  local formatter = clients[1]
  if vim.bo.filetype == "python" then
    for _, client in ipairs(clients) do
      if client.name == "ruff" then formatter = client; break end
    end
  end
  vim.lsp.buf.format({ async = false, timeout_ms = 5000, id = formatter.id })
  return true
end

return M
