require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },
  {
    import = "community",
  },
  {
    import = "plugins",
  },
}, --[[@as LazySpec]] {
  install = {
    colorscheme = {
      "habamax",
      "astrodark",
      "vscode",
      "gruvbox",
      "dracula",
      "catppuccin",
      "neovim-ayu",
      "tokyonight-night",
      "nordfox",
      "nightfox",
      "iceberg",
    },
  },
  checker = { enable = true },
  ui = {
    size = {
      width = 0.85,
      height = 0.75,
    },
    backdrop = 100,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
