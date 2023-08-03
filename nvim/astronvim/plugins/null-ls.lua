return {
    "jose-elias-alvarez/null-ls.nvim",

    opts = function(_, config)
        local null_ls = require "null-ls"
        local formatting = null_ls.builtins.formatting
        local linters = null_ls.builtins.diagnostics

        config.sources = {
            formatting.clang_format.with { extra_args = { "-style=file:/home/un/.clang-format" } },

            linters.cpplint.with {
                args = {
                    "--linelength",
                    "120",
                    "--filter="
                        .. "-legal/copyright,"
                        .. "-whitespace/braces,"
                        .. "-readability/casting,"
                        .. "-readability/alt_tokens,"
                        .. "-build/include_subdir,"
                        .. "-runtime/threadsafe_fn,"
                        .. "-build/include_subdir",
                    "$FILENAME",
                },
            },
        }

        return config
    end,
}
