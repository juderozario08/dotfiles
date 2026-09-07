return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
        local markdown = require("render-markdown")
        markdown.setup({
            latex = { enabled = false },
            enabled = true,
        })
        vim.keymap.set("n", "<leader>md", markdown.toggle, { desc = "Toggle Markdown Render" })
    end
}
