return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim', 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function()
        local markdown = require("render-markdown")
        vim.keymap.set("n", "<leader>md", markdown.toggle, {})
    end
}
