return {
    "numToStr/Comment.nvim",
    config = function()
        local comment = require("Comment")
        local ft = require("Comment.ft")
        comment.setup({
            padding = true,
            sticky = true,
            toggler = {
                line = "gcc",
                block = "gbc",
            },
            opleader = {
                line = "gc",
                block = "gb",
            },
            extra = {
                above = "gcO",
                below = "gco",
                eol = "gcA",
            },
            mappings = {
                basic = true,
                extra = true,
            },
        })
        ft({ "jsx", "tsx" }, { "{/*%s*/}", "{/*%s*/}" })
    end,
}
