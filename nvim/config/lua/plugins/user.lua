---@type LazySpec
return {
  -- * Add Plugins * --

  { "max397574/better-escape.nvim" },
  {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    cmd = "FineCmdline",
  },

  -- * Overriding Plugins * --

  -- Themes settings:
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { mini = true } },
  },

  -- Overriding:
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "120",
      disabled_filetypes = { "alpha", "neo-tree", "starter", "help", "text", "markdown", "make" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "gruvbox",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    },
  },
  {
    "michaelb/sniprun",
    opts = {
      display = { "Terminal" },
    },
    cmd = { "SnipRun", "SnipClose" },
  },
  {
    "andweeb/presence.nvim",
    opts = {
      neovim_image_text = "tg: @qnllnq",
      client_id = "793271441293967371",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    opts = { hint_enable = true },
    config = function() require("lsp_signature").setup() end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        "лоh",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
}
