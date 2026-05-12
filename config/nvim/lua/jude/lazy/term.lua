return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 10,
            direction = "float",
            float_opts = {
                border = "single",
                width = 90,
                height = 40,
                winblend = 3,
                highlights = {
                    Normal = { guibg = "#000000" },
                    NormalFloat = { link = "Normal" },
                    FloatBorder = { guifg = "#5c6370", guibg = "#1f2335" },
                },
                shadow = true,            -- Enable shadow
                shadow_blend = 60,        -- Set shadow blend level (0-100, default: 50)
                shadow_guibg = "#1f2335", -- Set shadow color
            },
            close_on_exit = false,        -- Disable auto-closing
            shell = vim.o.shell,
            auto_scroll = true,
        })

        -- Set key mappings
        vim.api.nvim_set_keymap(
            "n",
            "<C-t>",
            '<cmd>lua require("toggleterm").toggle()<CR>',
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap("t", "<C-s>", [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
}
