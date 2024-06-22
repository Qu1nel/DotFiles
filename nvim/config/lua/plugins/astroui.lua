---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "gruvbox",
    highlights = {
      init = { -- this table overrides highlights in all themes
        Normal = { guibg = nil, ctermbg = nil, bg = nil },
        NormalNC = { bg = nil, ctermbg = nil },
        CursorColumn = { cterm = nil, ctermbg = nil, ctermfg = nil },
        CursorLine = { cterm = {}, ctermbg = nil, ctermfg = nil },
        CursorLineNr = { cterm = {}, ctermbg = nil, ctermfg = nil },
        SignColumn = {},
        StatusLine = {},
        NeoTreeNormal = { bg = nil, ctermbg = nil },
        NeoTreeNormalNC = { bg = nil, ctermbg = nil },
        require("notify").setup {
          background_colour = "#000000",
        },
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
