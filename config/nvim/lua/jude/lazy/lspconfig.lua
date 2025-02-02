return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                auto_install = true,
            },
        },
        "neovim/nvim-lspconfig",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
        "FractalBoy/perl-language-server"
    },
    config = function()
        require("mason").setup()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("neoconf").setup()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end,
        })
        require("neodev").setup({})
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    completion = { callSnippet = "Replace" },
                },
            },
        })
    end,
}
