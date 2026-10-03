return {
    -- use mason-lspconfig to configure LSP installations
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
            opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
                "lua_ls",
                "clangd",
                "pyright",
            })
        end,
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    {
        "jay-babu/mason-null-ls.nvim",
        opts = function(_, opts)
            opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
                "stylua",
                "black",
                "clang-format",
                "isort",
                "prettierd",
                "cpplint",
                "ruff",
                "mypy",
            })
        end,
    },
    -- use mason-nvim-dap to configure Debugging instalaltions
    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
            opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
                -- "python"
            })
        end,
    },
}
