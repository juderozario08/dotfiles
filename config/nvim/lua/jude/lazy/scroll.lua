return {
    "petertriho/nvim-scrollbar",
    config = function()
        local colors = require("tokyonight.colors")
        require("scrollbar").setup({
            handle = {
                color = colors.bg_highlight,
            },
            marks = {
                Search = { color = colors.orange },
                Error = { color = colors.error },
                Warn = { color = colors.warning },
                Hint = { color = colors.hint },
                Info = { color = colors.info },
                Misc = { color = colors.purple },
            }
        })
        require("gitsigns").setup()
        require("scrollbar.handlers.gitsigns").setup()
    end
}
