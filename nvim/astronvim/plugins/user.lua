local utils = require "astronvim.utils"

return {
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
    },
    {
        "michaelb/sniprun",
        keys = {},
        opts = {},
        build = "bash ./install.sh 1",
        cmd = "SnipRun",
    },
    {
        "andweeb/presence.nvim",
        event = "VeryLazy",
        opts = {
            -- General options
            main_image = "neovim",
            -- client_id = "1009122352916857003",
            client_id = "793271441293967371",
            neovim_image_text = "bending computers to my own will.",
            show_time = true, -- Show the timer

            -- Rich Presence text options
            editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
            file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
            git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
            plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
            reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
            workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
            line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
        },
    },
    {
        "wakatime/vim-wakatime",
        event = "User AstroFile",
    },

    {
        "VonHeikemen/fine-cmdline.nvim",
        dependencies = {
            { "MunifTanjim/nui.nvim" },
        },
        cmd = "FineCmdline",
    },
    {
        "m4xshen/smartcolumn.nvim",
        event = { "InsertEnter", "User AstroFile" },
        opts = {
            colorcolumn = "120",
            disabled_filetypes = { "help", "text", "markdown", "make" },
        },
    },
    {
        "levouh/tint.nvim",
        event = "User AstroFile",
        opts = {
            highlight_ignore_patterns = { "WinSeparator", "neo-tree", "Status.*" },
            tint = -45, -- Darken colors, use a positive value to brighten
            saturation = 0.6, -- Saturation to preserve
        },
    },
    {
        { "NvChad/nvim-colorizer.lua", enabled = false },
        {
            "uga-rosa/ccc.nvim",
            event = { "User AstroFile", "InsertEnter" },
            cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
            keys = {
                { "<leader>uC", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle colorizer" },
                { "<leader>zc", "<cmd>CccConvert<cr>", desc = "Convert color" },
                { "<leader>zp", "<cmd>CccPick<cr>", desc = "Pick Color" },
            },
            opts = {
                highlighter = {
                    auto_enable = true,
                    lsp = true,
                },
            },
            config = function(_, opts)
                require("ccc").setup(opts)
                if opts.highlighter and opts.highlighter.auto_enable then vim.cmd.CccHighlighterEnable() end
            end,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "andymass/vim-matchup" },
        init = function()
            vim.g.matchup_matchparen_offscreen =
                { method = "popup", fullwidth = 1, highlight = "Normal", syntax_hl = 1 }
            vim.g.matchup_matchparen_deferred = 1
        end,
        opts = { matchup = { enable = true } },
    },
    {
        "echasnovski/mini.move",
        keys = {
            { "<A-h>", mode = "n", desc = "Move line left" },
            { "<A-j>", mode = "n", desc = "Move line down" },
            { "<A-k>", mode = "n", desc = "Move line up" },
            { "<A-l>", mode = "n", desc = "Move line right" },
            { "<A-h>", mode = "v", desc = "Move selection left" },
            { "<A-j>", mode = "v", desc = "Move selection down" },
            { "<A-k>", mode = "v", desc = "Move selection up" },
            { "<A-l>", mode = "v", desc = "Move selection right" },
        },
        opts = {
            mappings = {
                left = "<A-h>",
                right = "<A-l>",
                down = "<A-j>",
                up = "<A-k>",
                line_left = "<A-h>",
                line_right = "<A-l>",
                line_down = "<A-j>",
                line_up = "<A-k>",
            },
        },
    },
    {
        "catppuccin/nvim",
        optional = true,
        opts = { integrations = { mini = true } },
    },
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            window = {
                backdrop = 1,
                width = function() return math.min(120, vim.o.columns * 0.75) end,
                height = 0.9,
                options = {
                    number = false,
                    relativenumber = false,
                    foldcolumn = "0",
                    list = false,
                    showbreak = "NONE",
                    signcolumn = "no",
                },
            },
            plugins = {
                options = {
                    cmdheight = 1,
                    laststatus = 0,
                },
            },
            on_open = function() -- disable diagnostics, indent blankline, winbar, and offscreen matchup
                vim.g.diagnostics_mode_old = vim.g.diagnostics_mode
                vim.g.diagnostics_mode = 0
                vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])

                vim.g.indent_blankline_enabled_old = vim.g.indent_blankline_enabled
                vim.g.indent_blankline_enabled = false
                vim.g.miniindentscope_disable_old = vim.g.miniindentscope_disable
                vim.g.miniindentscope_disable = true

                vim.g.winbar_old = vim.wo.winbar
                vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter", "BufNew" }, {
                    pattern = "*",
                    callback = function() vim.wo.winbar = nil end,
                    group = vim.api.nvim_create_augroup("disable_winbar", { clear = true }),
                    desc = "Ensure winbar stays disabled when writing to file, switching buffers, opening floating windows, etc.",
                })

                if utils.is_available "vim-matchup" then
                    vim.cmd.NoMatchParen()
                    vim.g.matchup_matchparen_offscreen_old = vim.g.matchup_matchparen_offscreen
                    vim.g.matchup_matchparen_offscreen = {}
                    vim.cmd.DoMatchParen()
                end
            end,
            on_close = function() -- restore diagnostics, indent blankline, winbar, and offscreen matchup
                vim.g.diagnostics_mode = vim.g.diagnostics_mode_old
                vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])

                vim.g.indent_blankline_enabled = vim.g.indent_blankline_enabled_old
                vim.g.miniindentscope_disable = vim.g.miniindentscope_disable_old
                if vim.g.indent_blankline_enabled_old then vim.cmd "IndentBlanklineRefresh" end

                vim.api.nvim_clear_autocmds { group = "disable_winbar" }
                vim.wo.winbar = vim.g.winbar_old

                if utils.is_available "vim-matchup" then
                    vim.g.matchup_matchparen_offscreen = vim.g.matchup_matchparen_offscreen_old
                    vim.cmd.DoMatchParen()
                end
            end,
        },
    },
    {
        "folke/todo-comments.nvim",
        opts = {},
        event = "User AstroFile",
    },
    {
        "rebelot/heirline.nvim",
        opts = function(_, opts)
            local status = require "astronvim.utils.status"

            opts.winbar = { -- create custom winbar
                -- store the current buffer number
                init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
                fallthrough = false, -- pick the correct winbar based on condition
                -- inactive winbar
                {
                    condition = function() return not status.condition.is_active() end,
                    -- show the path to the file relative to the working directory
                    status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
                    -- add the file name and icon
                    status.component.file_info {
                        file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
                        file_modified = false,
                        file_read_only = false,
                        hl = status.hl.get_attributes("winbarnc", true),
                        surround = false,
                        update = "BufEnter",
                    },
                },
                -- active winbar
                {
                    -- show the path to the file relative to the working directory
                    status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
                    -- add the file name and icon
                    status.component.file_info { -- add file_info to breadcrumbs
                        file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
                        file_modified = false,
                        file_read_only = false,
                        hl = status.hl.get_attributes("winbar", true),
                        surround = false,
                        update = "BufEnter",
                    },
                    -- show the breadcrumbs
                    status.component.breadcrumbs {
                        icon = { hl = true },
                        hl = status.hl.get_attributes("winbar", true),
                        prefix = true,
                        padding = { left = 0 },
                    },
                },
            }

            return opts
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "gruvbox",
                -- section_separators = { left = "", right = "" },
                -- component_separators = { left = "", right = "" },
            },
        },
    },
    {
        "rebelot/heirline.nvim",
        optional = true,
        opts = function(_, opts) opts.statusline = nil end,
    },

    -- Themes:
    "Shatur/neovim-ayu",
}
