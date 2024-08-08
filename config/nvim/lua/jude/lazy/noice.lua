return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		require("noice").setup({
			cmdline = { enabled = false },
			messages = { enabled = false },
			popupmenu = { enabled = false, backend = "nui" },
			notify = { enabled = false },
			lsp = {
				progress = { enabled = true },
				message = { enabled = false },
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		})
	end,
}
