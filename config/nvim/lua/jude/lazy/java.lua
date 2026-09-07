return {
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason.nvim",
        },
        config = function()
            local jdtls = require("jdtls")

            local function start_jdtls()
                local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
                local root_dir = require("jdtls.setup").find_root(root_markers)
                if not root_dir or root_dir == "" then
                    root_dir = vim.fn.getcwd()
                end

                local project_name = vim.fs.basename(root_dir)
                local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

                local capabilities = require("blink.cmp").get_lsp_capabilities()
                local extendedClientCapabilities = jdtls.extendedClientCapabilities
                extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

                local config = {
                    cmd = {
                        vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
                        "-data",
                        workspace_dir,
                    },
                    root_dir = root_dir,
                    capabilities = capabilities,
                    init_options = {
                        extendedClientCapabilities = extendedClientCapabilities,
                    },
                    settings = {
                        java = {
                            signatureHelp = { enabled = true },
                            contentProvider = { preferred = "fernflower" },
                            completion = {
                                favoriteStaticMembers = {
                                    "org.hamcrest.MatcherAssert.assertThat",
                                    "org.hamcrest.Matchers.*",
                                    "org.hamcrest.CoreMatchers.*",
                                    "org.junit.jupiter.api.Assertions.*",
                                    "java.util.Objects.requireNonNull",
                                    "java.util.Objects.requireNonNullElse",
                                    "org.mockito.Mockito.*",
                                },
                                filteredTypes = {
                                    "com.sun.*",
                                    "io.micrometer.shaded.*",
                                    "java.awt.*",
                                    "jdk.*",
                                    "sun.*",
                                },
                                importOrder = {
                                    "java",
                                    "javax",
                                    "com",
                                    "org",
                                },
                            },
                            sources = {
                                organizeImports = {
                                    starThreshold = 9999,
                                    staticStarThreshold = 9999,
                                },
                            },
                            codeGeneration = {
                                toString = {
                                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                                },
                                useBlocks = true,
                            },
                            inlayHints = {
                                parameterNames = {
                                    enabled = "all",
                                },
                            },
                        },
                    },
                    on_attach = function(_, bufnr)
                        local opts = { buffer = bufnr, silent = true }
                        vim.keymap.set("n", "<leader>oi", function()
                            jdtls.organize_imports()
                        end, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))

                        vim.keymap.set("n", "<leader>ev", function()
                            jdtls.extract_variable()
                        end, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))

                        vim.keymap.set("v", "<leader>ev", function()
                            jdtls.extract_variable(true)
                        end, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))

                        vim.keymap.set("v", "<leader>em", function()
                            jdtls.extract_method(true)
                        end, vim.tbl_extend("force", opts, { desc = "Extract Method" }))
                    end,
                }

                jdtls.start_or_attach(config)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = start_jdtls,
            })

            if vim.bo.filetype == "java" then
                start_jdtls()
            end
        end,
    },
}
