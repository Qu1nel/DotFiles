return {
    "AstroNvim/astrocommunity",

    { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = "120",
            disabled_filetypes = { "help", "text" },
            scope = "file",
        },
    },

    { import = "astrocommunity.scrolling.mini-animate" },

    { import = "astrocommunity.motion.vim-matchup" },

    { import = "astrocommunity.motion.mini-move" },

    { import = "astrocommunity.media.vim-wakatime" },
}
