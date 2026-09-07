return {
    -- snacks.terminal is used for terminal integration (configured with <C-t> in snacks.lua)
    {
        "folke/snacks.nvim",
        opts = {
            terminal = {
                win = {
                    style = "float",
                    border = "rounded",
                    width = 0.85,
                    height = 0.8,
                },
            },
        },
    },
}
