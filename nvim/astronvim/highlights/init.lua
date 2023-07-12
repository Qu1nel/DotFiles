return {
    Normal = { guibg = nil, ctermbg = nil },
    NormalNC = { bg = nil, ctermbg = nil },
    CursorColumn = { cterm = nil, ctermbg = nil, ctermfg = nil },
    CursorLine = { cterm = {}, ctermbg = nil, ctermfg = nil },
    CursorLineNr = { cterm = {}, ctermbg = nil, ctermfg = nil },
    LineNr = {},
    SignColumn = {},
    StatusLine = {},
    NeoTreeNormal = { bg = nil, ctermbg = nil },
    NeoTreeNormalNC = { bg = nil, ctermbg = nil },
    require("notify").setup {
        background_colour = "#000000",
    },
}
