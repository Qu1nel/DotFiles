local M = {}

function M.check()
  vim.health.start("DotFiles Windows profile")
  if vim.fn.has("nvim-0.12.5") == 1 then vim.health.ok("Neovim 0.12.5 or newer") else vim.health.error("Neovim 0.12.5 or newer is required") end
  local languages = require("dotfiles.languages")
  for _, tool in ipairs({ "git", "rg", "ruff", "pyright-langserver", "gopls", "yaml-language-server", "taplo", "markdownlint" }) do
    local command = languages.command(tool)
    if command then vim.health.ok(tool .. ": " .. table.concat(command, " ")) else vim.health.warn(tool .. " is missing; run the Windows installer to install tools") end
  end
  for _, module in ipairs({ "lazy", "mini.pick", "nvim-tree", "lint" }) do
    if pcall(require, module) then vim.health.ok(module .. " available") else vim.health.error(module .. " is missing; reinstall plugins") end
  end
  vim.health.info("Config: " .. vim.fn.stdpath("config"))
  vim.health.info("Data: " .. vim.fn.stdpath("data"))
  vim.health.info("Formatting runs only through :Format or <Space>lf. Markdown has linting only.")
end

return M
