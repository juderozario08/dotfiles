return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "regex",
                "json",
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
                "scss",
            },
            ignore_install = {},
            modules = {},
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
