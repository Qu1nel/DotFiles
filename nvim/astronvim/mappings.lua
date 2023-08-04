local keymaps = { n = {}, i = {}, v = {} }

-- Default:
keymaps.n["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
keymaps.n["<leader>ит"] = keymaps.n["<leader>bn"]

-- Disable default:
-- Makes more sense to use "\" as vert split and "|" as split, because I use vert split more often
keymaps.n["<leader>bb"] = false
keymaps.n["<leader>bd"] = false
keymaps.n["<leader>ии"] = keymaps.n["<leader>bb"]
keymaps.n["<leader>ив"] = keymaps.n["<leader>bd"]

-- Quick command:
keymaps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }
keymaps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force save file" }
keymaps.n["<C-й>"] = keymaps.n["<C-q>"]
keymaps.n["<C-ы>"] = keymaps.n["<C-s>"]

-- Insert mode:
keymaps.i["kj"] = { "<esc>", desc = "Command mode" }
keymaps.i["ло"] = keymaps.i["kj"]

-- Z mode:
keymaps.n["<F2>"] = {
    function() vim.cmd "Z" end,
    desc = "Z mode",
}

-- Better gg and G:
keymaps.n["gj"] = { "G", desc = "go to last line" }
keymaps.n["gk"] = { "gg", desc = "go to first line" }
keymaps.v["gj"] = { "G", desc = "go to last line" }
keymaps.v["gk"] = { "gg", desc = "go to first line" }

keymaps.n["по"] = keymaps.n["gj"]
keymaps.n["пл"] = keymaps.n["gk"]
keymaps.v["по"] = keymaps.v["gj"]
keymaps.v["пл"] = keymaps.v["gk"]

-- Better gg and G:
keymaps.n["gh"] = { "^", desc = "go to beginning of the line (^)" }
keymaps.n["gl"] = { "$", desc = "go to end of the line ($)" }
keymaps.v["gh"] = { "^", desc = "go to beginning of the line (^)" }
keymaps.v["gl"] = { "$", desc = "go to end of the line ($)" }

keymaps.n["пр"] = keymaps.n["gh"]
keymaps.n["пд"] = keymaps.n["gl"]
keymaps.v["пр"] = keymaps.v["gh"]
keymaps.v["пд"] = keymaps.v["gl"]

-- Close buffers:
keymaps.n["<leader>c"] = {
    function() require("astronvim.utils.buffer").close() end,
    desc = "Close current buffer",
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
keymaps.n["<leader>с"] = keymaps.n["<leader>c"]
keymaps.n["<leader>С"] = keymaps.n["<leader>C"]
keymaps.n["<leader>ис"] = keymaps.n["<leader>bc"]
keymaps.n["<leader>иС"] = keymaps.n["<leader>bC"]
keymaps.n["<leader>ив"] = keymaps.n["<leader>bd"]

-- Switch buffers
keymaps.n["<tab>"] = {
    function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Next buffer",
}
keymaps.n["<S-tab>"] = {
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
keymaps.n["<leader>о"] = keymaps.n["<leader>j"]

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
keymaps.n["<leader>им"] = keymaps.n["<leader>bv"]
keymaps.n["<leader>иы"] = keymaps.n["<leader>bs"]

return keymaps
