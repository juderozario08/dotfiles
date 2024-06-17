return {
    "shellRaining/hlchunk.nvim",
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                notify = true,
                use_treesitter = false,
                style = {
                    { fg = "#555555" },
                },
            },
            indent = { enable = false, },
            line_num = { enable = false, },
            blank = { enable = false },
        })
    end,
}
