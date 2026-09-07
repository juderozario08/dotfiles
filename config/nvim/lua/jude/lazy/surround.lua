return {
    "echasnovski/mini.surround",
    keys = function(_, keys)
        local mappings = {
            { "gza", desc = "Add Surrounding",            mode = { "n", "v" } },
            { "gzd", desc = "Delete Surrounding" },
            { "gzf", desc = "Find Right Surrounding" },
            { "gzF", desc = "Find Left Surrounding" },
            { "gzh", desc = "Highlight Surrounding" },
            { "gzr", desc = "Replace Surrounding" },
            { "gzn", desc = "Update `MiniSurround.config.n_lines`" },
        }
        return vim.list_extend(mappings, keys)
    end,
    opts = {
        mappings = {
            add = "gza",            -- Add surrounding in Normal and Visual modes
            delete = "gzd",         -- Delete surrounding
            find = "gzf",           -- Find surrounding (to the right)
            find_left = "gzF",      -- Find surrounding (to the left)
            highlight = "gzh",      -- Highlight surrounding
            replace = "gzr",        -- Replace surrounding
            update_n_lines = "gzn", -- Update `n_lines`
        },
    },
}
