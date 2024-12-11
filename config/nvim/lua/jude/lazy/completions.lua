return {
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-cmdline",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            require("luasnip").setup({})
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        cmp.config.window.bordered(),
                        autocomplete = false,
                    },
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-n>"] = cmp.mapping.select_next_item({ select = false }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ select = false }),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-o>"] = function()
                        if cmp.visible_docs() then
                            cmp.close_docs()
                        else
                            cmp.open_docs()
                        end
                    end
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", group_index = 1 },
                    { name = "path",     group_index = 1 },
                    { name = "luasnip",  group_index = 1 },
                    { name = "nvim_lua", group_index = 1 },
                    { name = "buffer",   group_index = 2 },
                }, {}),
                view = {
                    docs = {
                        auto_open = false
                    }
                }
            })
            -- `/` cmdline setup.
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
