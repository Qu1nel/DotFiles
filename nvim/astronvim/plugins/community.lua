return {
    "AstroNvim/astrocommunity",

    { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = "120",
        },
    },

    { import = "astrocommunity.motion.vim-matchup" },
    { import = "astrocommunity.motion.mini-move" },
    { import = "astrocommunity.media.vim-wakatime" },
    { import = "astrocommunity.editing-support.zen-mode-nvim" },
    { import = "astrocommunity.editing-support.todo-comments-nvim" },
    { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
    { import = "astrocommunity.bars-and-lines.lualine-nvim" },
}
