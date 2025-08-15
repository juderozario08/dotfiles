-- return {
--     "folke/noice.nvim",
--     event = "VeryLazy",
--     dependencies = { "MunifTanjim/nui.nvim" },
--     config = function()
--         require("noice").setup({
--             cmdline = { enabled = false },
--             messages = { enabled = false },
--             popupmenu = { enabled = false, backend = "nui" },
--             notify = { enabled = false },
--             lsp = {
--                 progress = { enabled = true },
--                 message = { enabled = false },
--                 override = {
--                     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--                     ["vim.lsp.util.stylize_markdown"] = true,
--                     ["cmp.entry.get_documentation"] = true,
--                 }
--             },
--             presets = {
--                 bottom_search = true,
--                 command_palette = true,
--                 long_message_to_split = true,
--                 inc_rename = false,
--                 lsp_doc_border = true,
--             },
--         })
--     end,
-- }

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            lsp_doc_border = true
        },
    },
    -- stylua: ignore
    keys = {
        {
            "<leader>snd",
            function()
                require("noice").cmd("dismiss")
            end,
            desc = "Dismiss All"
        },
    },
    config = function(_, opts)
        -- HACK: noice shows messages from before it was enabled,
        -- but this is not ideal when Lazy is installing plugins,
        -- so clear the messages in this case.
        if vim.o.filetype == "lazy" then
            vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
    end,
}
