return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = true,
        automatic_installation = true
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {}
        },
        "neovim/nvim-lspconfig",
        {
            "folke/neoconf.nvim",
            config = function()
                require("neoconf").setup({})
            end
        }
    }
}
