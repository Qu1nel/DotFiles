return {
    "morhetz/gruvbox",
    "Shatur/neovim-ayu",
    "Mofiqul/vscode.nvim",
    "cocopon/iceberg.vim",

    "p00f/clangd_extensions.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "clangd" },
        },
    },
}
