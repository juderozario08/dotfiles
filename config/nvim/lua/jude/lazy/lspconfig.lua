return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            mason.setup({
                ui = {
                    border = "rounded",
                },
            })

            -- Setup blink.cmp capabilities for fast completions and snippets
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            codeLens = {
                                enable = true,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            doc = {
                                privateName = { "^_" },
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                        },
                    },
                },
                rust_analyzer = {},
                clangd = {},
                ts_ls = {},
                bashls = {},
                gopls = {},
                marksman = {},
                pyright = {},
            }

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
                automatic_enable = {
                    exclude = { "jdtls" },
                },
                handlers = {
                    function(server_name)
                        if server_name == "jdtls" then
                            return
                        end
                        local server_opts = servers[server_name] or {}
                        server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
                        lspconfig[server_name].setup(server_opts)
                    end,
                },
            })

            -- Diagnostics styling
            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                },
            })

            -- Additional non-conflicting diagnostic keymaps (user's LspAttach keymaps remain in init.lua)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
            vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
        end,
    },
}
