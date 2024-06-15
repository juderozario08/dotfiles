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
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        require("mason").setup()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("neoconf").setup()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({})
            end,
        })
        require("neodev").setup()
        local lspconfig = require("lspconfig")
        lspconfig.tsserver.setup({
            capabilities = capabilities,
        })
        lspconfig.elixirls.setup({
            capabilities = capabilities,
        })
        lspconfig.eslint.setup({
            capabilities = capabilities,
        })
        lspconfig.golangci_lint_ls.setup({
            capabilities = capabilities,
        })
        lspconfig.htmx.setup({
            capabilities = capabilities,
        })
        lspconfig.jsonls.setup({
            capabilities = capabilities,
        })
        lspconfig.pylsp.setup({
            capabilities = capabilities,
        })
        lspconfig.quick_lint_js.setup({
            capabilities = capabilities,
        })
        lspconfig.vtsls.setup({
            capabilities = capabilities,
        })
        lspconfig.cssls.setup({
            capabilities = capabilities,
        })
        lspconfig.cmake.setup({
            capabilities = capabilities,
        })
        lspconfig.bashls.setup({
            capabilities = capabilities,
        })
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
        })
        lspconfig.html.setup({
            capabilities = capabilities,
        })
        lspconfig.gopls.setup({
            capabilities = capabilities,
            settings = {
                gopls = {
                    completeUnimported = true,
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        })
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
