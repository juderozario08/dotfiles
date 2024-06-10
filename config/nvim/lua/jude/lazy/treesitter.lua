return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "regex",
                    "jsonc",
                    "markdown_inline",
                    "lua",
                    "python",
                    "yaml",
                    "toml",
                    "html",
                    "css",
                    "javascript",
                    "typescript",
                    "tsx",
                    "cpp",
                    "rust",
                    "go",
                    "php",
                    "json",
                    "dockerfile",
                    "vue",
                    "svelte",
                    "scss",
                },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 3,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 2,
                on_attach = nil,
            })
        end,
    },
}
