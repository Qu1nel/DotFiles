local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = -1
opt.smartindent = true
opt.wrap = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 500
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
opt.langremap = false
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

local group = vim.api.nvim_create_augroup("DotfilesOptions", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "go", "gomod", "gowork" },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 0
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "yaml", "json", "jsonc", "lua" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
  end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function() vim.hl.on_yank() end,
})
