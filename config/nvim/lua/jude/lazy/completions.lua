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
            require("luasnip.loaders.from_vscode").lazy_load()
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
                    ["C-b"] = cmp.mapping.scroll_docs(-4),
                    ["C-f"] = cmp.mapping.scroll_docs(4),
                    ["C-Space"] = cmp.mapping.complete(),
                    ["C-e"] = cmp.mapping.abort(),
                    ["C-n"] = cmp.mapping.select_next_item({ select = false }),
                    ["C-p"] = cmp.mapping.select_prev_item({ select = false }),
                    ["C-y>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                        group_index = 1,
                        entry_filter = function(entry, _)
                            local lsp = require("cmp.types").lsp
                            return lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
                        end,
                    },
                    { name = "path",     group_index = 1 },
                    { name = "luasnip",  group_index = 1 },
                    { name = "nvim_lua", group_index = 2 },
                    { name = "buffer",   group_index = 3 },
                }, {}),
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
