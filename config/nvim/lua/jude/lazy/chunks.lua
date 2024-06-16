return {
    "shellRaining/hlchunk.nvim",
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = false,
                notify = true,
            },
            indent = {
                enable = true,
                notify = true,
                use_treesitter = false,
                style = {
                    { fg = "#333333" },
                },
            },
            line_num = {
                enable = false,
            },
            blank = { enable = false },
        })
    end,
}
