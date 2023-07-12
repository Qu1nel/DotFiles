return {
    "morhetz/gruvbox",
    "Shatur/neovim-ayu",
    "Mofiqul/vscode.nvim",
    "cocopon/iceberg.vim",
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    "p00f/clangd_extensions.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "clangd" },
        },
    },
}
