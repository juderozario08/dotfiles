return {
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",
        opts = {
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<C-y>"] = { "select_and_accept" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    border = "rounded",
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = "rounded",
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lsp = {
                        score_offset = 100,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            snippets = {
                preset = "default",
            },
            signature = {
                enabled = true,
                window = { border = "rounded" },
            },
        },
        opts_extend = { "sources.default" },
    },
}
