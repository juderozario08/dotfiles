return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({})
        vim.keymap.set("n", "<leader>-", ":Oil<CR>", { noremap = true, silent = true })
    end,
}
