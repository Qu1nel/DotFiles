return {
    "p00f/clangd_extensions.nvim",
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
    },

    -- Themes:
    "morhetz/gruvbox",
    "Shatur/neovim-ayu",
    "Mofiqul/vscode.nvim",
    "cocopon/iceberg.vim",
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
