return {
    "shellRaining/hlchunk.nvim",
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                notify = true,
                use_treesitter = false,
                chars = {
                    horizontal_line = "─",
                    vertical_line = "│",
                    left_top = "╭",
                    left_bottom = "╰",
                    right_arrow = ">",
                },
                style = {
                    { fg = "#6DC6E3" }, -- Dim Yellow
                },
                textobject = "",
                max_file_size = 1024 * 1024,
                error_sign = true,
            },
            indent = { enable = false },
            line_num = {
                enable = true,
                use_treesitter = false,
                style = "#808000", -- Yellow
            },

            blank = { enable = false },
        })
    end,
}
