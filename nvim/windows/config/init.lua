vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("dotfiles.options")
require("dotfiles.mappings")

if vim.fn.has("nvim-0.12.5") == 0 then
  vim.schedule(function()
    vim.notify("This profile needs Neovim 0.12.5 or newer. Basic editing is available.", vim.log.levels.WARN)
  end)
  return
end

local tools = vim.env.DOTFILES_NVIM_TOOLS or (vim.fn.stdpath("data") .. "/tools")
local separator = vim.fn.has("win32") == 1 and ";" or ":"
vim.env.PATH = table.concat({ tools .. "/bin", tools .. "/node", tools .. "/go/bin", tools .. "/git/cmd", vim.env.PATH }, separator)

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazy_path .. "/lua/lazy/init.lua") then
  vim.schedule(function()
    vim.notify("Neovim plugins are missing. Run the DotFiles Windows installer; basic editing is available.", vim.log.levels.WARN)
  end)
  return
end

vim.opt.rtp:prepend(lazy_path)
local lazy_state = vim.fn.stdpath("state") .. "/state/dotfiles-lazy"
require("lazy").setup(require("dotfiles.plugins"), {
  root = vim.fn.stdpath("data") .. "/lazy",
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  state = lazy_state .. "/state.json",
  pkg = { cache = lazy_state .. "/pkg-cache.lua" },
  readme = { root = lazy_state .. "/readme" },
  install = { missing = false },
  checker = { enabled = false },
  change_detection = { enabled = false, notify = false },
  rocks = { enabled = false },
})
