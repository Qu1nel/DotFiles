local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end
local function plugin(module, callback)
  return function()
    local ok, value = pcall(require, module)
    if ok then callback(value) else vim.notify("This action needs installed plugins: " .. module, vim.log.levels.WARN) end
  end
end
local buffers = require("dotfiles.buffers")

map("n", "<C-s>", "<Cmd>write<CR>", "Save file")
map("n", "<Leader>w", "<Cmd>write<CR>", "Save file")
map("n", "<Leader>q", "<Cmd>wq<CR>", "Save and quit")
map("n", "<Leader>x", "<Cmd>wq<CR>", "Save and quit")
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", "Clear search highlight")
map("i", "kj", "<Esc>", "Leave insert mode")
for lhs, rhs in pairs({ gk = "gg", gj = "G", H = "g0", L = "g_", gh = "^" }) do
  map({ "n", "x" }, lhs, rhs, "Move " .. rhs)
end
map("n", "<Tab>", function() buffers.navigate(vim.v.count1) end, "Next buffer")
map("n", "<S-Tab>", function() buffers.navigate(-vim.v.count1) end, "Previous buffer")
map("n", "<Leader>j", function() buffers.pick() end, "Pick buffer")
map("n", "<Leader>c", function() buffers.close(0) end, "Close buffer")
map("n", "<Leader>C", function() buffers.close(0, true) end, "Discard and close buffer")
map("n", "<Leader>bc", function() buffers.pick("close") end, "Close picked buffer")
map("n", "<Leader>bC", function() buffers.close_all(false) end, "Close all buffers")
map("n", "<Leader>bD", function() buffers.close_all(true) end, "Close other buffers")
map("n", "<Leader>bv", function() buffers.pick("vertical") end, "Pick buffer in vertical split")
map("n", "<Leader>bh", function() buffers.pick("horizontal") end, "Pick buffer in horizontal split")
map("n", "<Leader>bs", function() buffers.pick("horizontal") end, "Pick buffer in horizontal split")
map("n", "<Leader>bn", "<Cmd>tabnew<CR>", "New tab")
map("n", "<Leader>\\", "<Cmd>vsplit<CR>", "Vertical split")
map("n", "<Leader>|", "<Cmd>split<CR>", "Horizontal split")
for _, direction in ipairs({ "h", "j", "k", "l" }) do
  map("n", "<C-" .. direction .. ">", "<C-w>" .. direction, "Move to window " .. direction)
end
map("n", "<Leader>e", plugin("nvim-tree.api", function(api) api.tree.toggle() end), "Toggle file tree")
map("n", "<Leader>o", plugin("nvim-tree.api", function(api) api.tree.open() end), "Focus file tree")
map("n", "<Leader>ff", plugin("mini.pick", function(pick) pick.builtin.files() end), "Find files")
map("n", "<Leader>fb", function() buffers.pick() end, "Find buffers")
map("n", "<Leader>fw", plugin("mini.pick", function(pick)
  if vim.fn.executable("rg") ~= 1 then vim.notify("Text search requires ripgrep (rg).", vim.log.levels.WARN); return end
  pick.builtin.grep_live({ tool = "rg" })
end), "Find text")
map("n", "<Leader>fh", plugin("mini.pick", function(pick) pick.builtin.help() end), "Find help")
map("n", "<F2>", plugin("mini.misc", function(misc) misc.zoom() end), "Toggle focused window")
map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
map("n", "<Leader>ld", vim.diagnostic.setloclist, "Buffer diagnostics")
map("n", "<Leader>lD", vim.diagnostic.setqflist, "Workspace diagnostics")
map("n", "<Leader>lf", function() require("dotfiles.languages").format() end, "Format buffer")
vim.api.nvim_create_user_command("Format", function() require("dotfiles.languages").format() end, { desc = "Format the current buffer explicitly" })
