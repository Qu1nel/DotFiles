return {
    function(_, opts)
        require("clangd_extensions").setup {
            server = opts
        }
    end,
}
