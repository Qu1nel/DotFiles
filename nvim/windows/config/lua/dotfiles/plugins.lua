return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-mini/mini.nvim",
    branch = "stable",
    lazy = false,
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.bufremove").setup()
      require("mini.pick").setup()
      require("mini.statusline").setup({ use_icons = false })
      require("mini.tabline").setup({ show_icons = false })
      require("mini.misc").setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      hijack_netrw = false,
      disable_netrw = true,
      view = { side = "left", width = 34 },
      hijack_directories = { enable = true, auto_open = true },
      update_focused_file = { enable = true },
      filters = { dotfiles = false },
      renderer = {
        icons = { show = { file = false, folder = false, folder_arrow = false, git = false, modified = false, diagnostics = false, bookmarks = false } },
      },
      actions = { open_file = { quit_on_open = false } },
      git = { enable = false },
      diagnostics = { enable = true, show_on_dirs = true },
    },
  },
  { "neovim/nvim-lspconfig", lazy = false, config = function() require("dotfiles.languages").setup_lsp() end },
  { "mfussenegger/nvim-lint", lazy = false, config = function() require("dotfiles.languages").setup_lint() end },
}
