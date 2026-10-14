return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            local query = require("vim.treesitter.query")

            local non_filetype_match_injection_language_aliases = {
                ex = "elixir",
                pl = "perl",
                sh = "bash",
                uxn = "uxntal",
                ts = "typescript",
            }

            local function get_parser_from_markdown_info_string(injection_alias)
                local match = vim.filetype.match({ filename = "a." .. injection_alias })
                return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
            end

            local html_script_type_languages = {
                ["importmap"] = "json",
                ["module"] = "javascript",
                ["application/ecmascript"] = "javascript",
                ["text/ecmascript"] = "javascript",
            }

            query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
                local capture_id = pred[2]
                local node = match[capture_id]
                if type(node) == "table" then node = node[1] end
                if not node then return end
                local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
                if ok and text then
                    local injection_alias = text:lower()
                    metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
                end
            end, { force = true })

            query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
                local capture_id = pred[2]
                local node = match[capture_id]
                if type(node) == "table" then node = node[1] end
                if not node then return end
                local ok, type_attr_value = pcall(vim.treesitter.get_node_text, node, bufnr)
                if ok and type_attr_value then
                    local configured = html_script_type_languages[type_attr_value]
                    if configured then
                        metadata["injection.language"] = configured
                    else
                        local parts = vim.split(type_attr_value, "/", {})
                        metadata["injection.language"] = parts[#parts]
                    end
                end
            end, { force = true })

            query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
                local id = pred[2]
                local node = match[id]
                if type(node) == "table" then node = node[1] end
                if not node then return end
                if not metadata[id] then metadata[id] = {} end
                local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr, { metadata = metadata[id] })
                if ok and text then
                    metadata[id].text = string.lower(text)
                end
            end, { force = true })

            query.add_predicate("nth?", function(match, _pattern, _bufnr, pred)
                local node = match[pred[2]]
                if type(node) == "table" then node = node[1] end
                local n = tonumber(pred[3])
                if node and node:parent() and node:parent():named_child_count() > n then
                    return node:parent():named_child(n) == node
                end
                return false
            end, { force = true })

            query.add_predicate("is?", function(match, _pattern, bufnr, pred)
                local locals = require("nvim-treesitter.locals")
                local node = match[pred[2]]
                if type(node) == "table" then node = node[1] end
                local types = { unpack(pred, 3) }
                if not node then return true end
                local _, _, kind = locals.find_definition(node, bufnr)
                return vim.tbl_contains(types, kind)
            end, { force = true })

            query.add_predicate("kind-eq?", function(match, _pattern, _bufnr, pred)
                local node = match[pred[2]]
                if type(node) == "table" then node = node[1] end
                local types = { unpack(pred, 3) }
                if not node then return true end
                return vim.tbl_contains(types, node:type())
            end, { force = true })

            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "diff",
                    "dockerfile",
                    "git_config",
                    "gitignore",
                    "go",
                    "html",
                    "hyprlang",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "rust",
                    "scss",
                    "tmux",
                    "toml",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                    disable = { "cpp" },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                            ["]a"] = "@parameter.inner",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                            ["[a"] = "@parameter.inner",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 10,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 10,
                max_lines = 5,
            })
        end,
    },
}
