return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        branch = "master",
        commit = "cf12346a",
        build = ":TSUpdate",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "lua",
                    "javascript",
                    "typescript",
                    "rust",
                    "go",
                    "yaml",
                    "toml",
                    "html",
                    "css",
                    "scss",
                },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true, disable = { "markdown", "markdown_inline" } },
                indent = {
                    enable = true,
                    disable = { "cpp" }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                            ["]a"] = "@parameter.inner",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                            ["[a"] = "@parameter.inner",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 10,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 10,
                on_attach = function(bufnr)
                    local ft = vim.bo[bufnr].filetype
                    if ft == "markdown" or ft == "markdown_inline" then
                        return false
                    else
                        return true
                    end
                end,
                max_lines = 5,
            })
        end,
    },
}
