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
		require("neodev").setup()
		local lspconfig = require("lspconfig")
		lspconfig.gopls.setup({
			capabilities = capabilities,
			settings = {
				gopls = {
					completeUnimported = true,
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
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
