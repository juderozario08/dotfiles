return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        require("telescope").setup({
            extensions = {
                ["ui-select"] = require("telescope.themes").get_dropdown({}),
            },
            codeactions = true,
            defaults = {
                layout_strategy = "flex",
                layout_config = {
                    width = 0.97,
                    height = 0.97,
                    prompt_position = "top",
                    flip_columns = 150,
                    horizontal = {
                        preview_width = 0.6,
                    },
                    vertical = {
                        preview_height = 0.6,
                    },
                },
            },
        })
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        require("telescope").load_extension("ui-select")
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fg", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>lb", function() builtin.live_grep({ grep_open_files = true, }) end, {})
        vim.keymap.set("n", "<leader>cb", builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("n", "<leader>tr", builtin.treesitter, {})
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
        vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, {})
        vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
        vim.keymap.set("n", "<leader>tm", builtin.man_pages, {})
        vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
        vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})
        vim.keymap.set("n", "<leader>fs", builtin.search_history, {})
        vim.keymap.set("n", "<leader>fc", builtin.diagnostics, {})
        vim.keymap.set("n", "<leader>fq", function()
            builtin.quickfix({
                show_line = true,
            })
        end, {})
        vim.keymap.set("n", "<leader>fj", function() builtin.jumplist({}) end, {})
    end,
}
