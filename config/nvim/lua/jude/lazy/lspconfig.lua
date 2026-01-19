-- return {
--     "mason-org/mason-lspconfig.nvim",
--     opts={
--         ensure_installed = { "lua_ls", "rust_analyzer" },
--     }
--     lazy = false,
--     dependencies = {
--         {
--             "mason-org/mason.nvim",
--             opts = {}
--         },
--         "neovim/nvim-lspconfig",
--     }
--     -- config = function()
--         -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
--         -- function(server_name)
--         --     require("lspconfig")[server_name].setup({
--         --         capabilities = capabilities,
--         --     })
--         -- end,
--     -- end,
-- }

return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "ts_ls", "bashls", "gopls" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
