return {
  {
    "AstroNvim/astrocore",
    --@type AstroCoreOpts
    opts = {
      mappings = {
        -- First char = mode switch
        n = { -- Command mode
          -- Disable mapping:
          ["<Leader>bb"] = false,
          ["<Leader>bp"] = false,
          ["<Leader>bd"] = false,

          -- Name of level commands:
          ["<Leader>b"] = { desc = "Buffers" },
          ["<Leader>z"] = { desc = "Colors" },

          -- Utils:
          ["<Leader>q"] = {
            "<Cmd>wq!<cr>",
            desc = "Quick exit with save changes",
          },
          ["<C-s>"] = {
            ":w!<cr>",
            desc = "Save changes",
          },
          [":"] = {
            "<Cmd>FineCmdline<CR>",
            desc = "Open command menu",
          },
          ["<F6>"] = {
            "<Cmd>SnipClose<CR>",
            desc = "Close terminal with compile code",
          },
          ["<F2>"] = {
            "<Cmd>ZenMode<CR>",
            desc = "Toggle zen mode",
          },

          -- * Quick control * --
          ["<tab>"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["<S-tab>"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previos buffer",
          },
          ["<Leader>j"] = {
            function()
              require("astroui.status").heirline.buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
            end,
            desc = "Jump to select buffer",
          },
          ["<Leader>c"] = {
            function() require("astrocore.buffer").close(0) end,
            desc = "Close current buffer",
          },
          ["<Leader>C"] = {
            function() require("astrocore.buffer").close(0, true) end,
            desc = "Force close curent buffer",
          },

          ["gk"] = { "gg", desc = "Go to the up of file" },
          ["gj"] = { "G", desc = "Go to the down of file" },
          ["H"] = { "g0", desc = "Go to the left of line" },
          ["L"] = { "g_", desc = "Go to the right of line" },

          -- * Closing buffers * --
          ["<Leader>bc"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Close picked buffer from tabline",
          },
          ["<Leader>bC"] = {
            function() require("astrocore.buffer").close_all() end,
            desc = "Close all buffers",
          },
          ["<Leader>bD"] = {
            function() require("astrocore.buffer").close_all(true) end,
            desc = "Close all buffers except current",
          },

          -- * Buffers Vertical or Horisontal pick * --
          ["<Leader>bv"] = {
            function()
              require("astroui.status").heirline.buffer_picker(function(bufnr)
                vim.cmd.vsplit()
                vim.api.nvim_win_set_buf(0, bufnr)
              end)
            end,
            desc = "Vertical file diff pick buffer",
          },
          ["<Leader>bh"] = {
            function()
              require("astroui.status").heirline.buffer_picker(function(bufnr)
                vim.cmd.split()
                vim.api.nvim_win_set_buf(0, bufnr)
              end)
            end,
            desc = "Horisontal file diff pick buffer",
          },
        },
        v = { -- Visual mode
          ["gk"] = { "gg", desc = "Go to the up of file" },
          ["gj"] = { "G", desc = "Go to the down of file" },
          ["H"] = { "g0", desc = "Go to the left of line" },
          ["L"] = { "g_", desc = "Go to the right of line" },
          ["<F6>"] = {
            ":SnipRun<cr>",
            desc = "Run selected part code",
          },
        },
        i = { -- Insert mode
          ["kj"] = { "<esc>", desc = "Switch to command mode" },
        },
      },
    },
  },
  -- This mapping will only be set in buffers with an LSP attached
  {
    "AstroNvim/astrolsp",
    --@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Show details object",
          },

          -- Condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Go to declaration of object",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
