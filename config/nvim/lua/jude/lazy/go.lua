return {
    {
        "olexsmir/gopher.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "ray-x/go.nvim",
                dependencies = {
                    "ray-x/guihua.lua",
                    "neovim/nvim-lspconfig",
                    "nvim-treesitter/nvim-treesitter",
                },
                config = function()
                    require("go").setup()
                    require("go.format").gofmt()
                    require("go.format").goimports()
                end,
                event = { "CmdlineEnter" },
                ft = { "go", "gomod" },
                build = ':lua require("go.install").update_all_sync()',
            },
        },
        config = function()
            require("gopher").setup({
                commands = {
                    go = "go",
                    gomodifytags = "gomodifytags",
                    gotests = "~/go/bin/gotests",
                    impl = "impl",
                    iferr = "iferr",
                    golines = "golines",
                },
            })
        end,
    },
}
