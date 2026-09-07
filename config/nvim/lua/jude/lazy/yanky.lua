return {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = {
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 150,
        },
    },
    keys = {
        {
            "<leader>y",
            function()
                if pcall(require, "telescope") then
                    pcall(require("telescope").load_extension, "yank_history")
                    require("telescope").extensions.yank_history.yank_history({})
                else
                    vim.cmd("YankyRingHistory")
                end
            end,
            desc = "Open Yank History",
        },
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
        { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
        { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
        { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
        { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
        { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
    },
}
