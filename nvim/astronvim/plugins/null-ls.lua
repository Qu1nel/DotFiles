return {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
        local null_ls = require "null-ls"
        local formatting = null_ls.builtins.formatting

        config.sources = {
            formatting.autopep8.with({ extra_args = { "--max-line-length", "120" } }),
            formatting.clang_format.with({ extra_args = { "-style=file:\"/home/un/.clang-format\"" } }),
        }

        return config
    end,
}
