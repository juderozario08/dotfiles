return {
    {
        "rafamadriz/friendly-snippets",
        lazy = true,
    },
    {
        "echasnovski/mini.snippets",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = function()
            local snippets = require("mini.snippets")
            return {
                snippets = {
                    -- Load language-specific snippets from friendly-snippets
                    snippets.gen_loader.from_lang(),
                },
            }
        end,
    },
}
