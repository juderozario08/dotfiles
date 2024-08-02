return {
    "github/copilot.vim",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>cd", [[:Copilot disable<CR>]])
        vim.keymap.set("n", "<leader>ce", [[:Copilot enable<CR>]])
    end,
}
