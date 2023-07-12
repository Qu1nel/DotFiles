local keymaps = { n = {}, i = {}, v = {} }

-- --*[ Default:
keymaps.n["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
-- --*]

-- --*[ disable default:
-- Makes more sense to use "\" as vert split and "|" as split, because I use vert split more often
keymaps.n["<leader>bb"] = false
keymaps.n["<leader>bd"] = false
-- --*]

-- --*[ Quick command:
keymaps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }
keymaps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force save file" }
-- --*]

-- --*[ Insert mode:
keymaps.i["kj"] = { "<esc>", desc = "Command mode" }
-- --*]
--
-- --*[ Z mode:
keymaps.n["<F2>"] = {
    function() vim.cmd "Z" end,
    desc = "Z mode",
}
-- --*]

-- --*[ Better gg and G:
keymaps.n["gj"] = { "G", desc = "go to last line" }
keymaps.n["gk"] = { "gg", desc = "go to first line" }
keymaps.v["gj"] = { "G", desc = "go to last line" }
keymaps.v["gk"] = { "gg", desc = "go to first line" }
-- --*]

-- --*[ Better gg and G:
keymaps.n["gh"] = { "^", desc = "go to beginning of the line (^)" }
keymaps.n["gl"] = { "$", desc = "go to end of the line ($)" }
keymaps.v["gh"] = { "^", desc = "go to beginning of the line (^)" }
keymaps.v["gl"] = { "$", desc = "go to end of the line ($)" }
-- --*]

-- --*[ Buffers keymaps:
-- Close buffers
keymaps.n["<leader>c"] = {
    function() require("astronvim.utils.buffer").close() end,
    desc = " Close current buffer",
}
keymaps.n["<leader>C"] = {
    function() require("astronvim.utils.buffer").close(0, true) end,
    desc = "Force close current buffer",
}
keymaps.n["<leader>bc"] = {
    function()
        require("astronvim.utils.status").heirline.buffer_picker(
            function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
    end,
    desc = "Close picked buffer from tabline",
}
keymaps.n["<leader>bC"] = {
    function() require("astronvim.utils.buffer").close_all() end,
    desc = "Close all buffers",
}
keymaps.n["<leader>bd"] = {
    function() require("astronvim.utils.buffer").close_all(true) end,
    desc = "Close all buffers except current",
}

-- Switch buffers
keymaps.n["<leader>bl"] = {
    function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Next buffer",
}
keymaps.n["<leader>bh"] = {
    function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    desc = "Rrevious buffer",
}

-- Pick buffers (Jump)
keymaps.n["<leader>j"] = {
    function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
    end,
    desc = "Select buffer from tabline",
}

-- Split pick buffers
keymaps.n["<leader>bv"] = {
    function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
            vim.cmd.vsplit()
            vim.api.nvim_win_set_buf(0, bufnr)
        end)
    end,
    desc = "Vertical file diff pick buffer",
}
keymaps.n["<leader>bs"] = {
    function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
            vim.cmd.split()
            vim.api.nvim_win_set_buf(0, bufnr)
        end)
    end,
    desc = "Horisontal file diff pick buffer",
}
-- --*] # Buffers keymaps

return keymaps
