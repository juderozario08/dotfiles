return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = false, animate = { enabled = false } },
        input = { enabled = true },
        notifier = {
            enabled = false,
            timeout = 3000,
        },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
        { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>n",       function() Snacks.picker.notifications() end,   desc = "Notification History" },
        -- find
        { "<leader>fp",      function() Snacks.picker.projects() end,        desc = "Projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,          desc = "Recent" },
        -- git
        { "<leader>gl",      function() Snacks.picker.git_log() end,         desc = "Git Log" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end,    desc = "Git Log Line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,      desc = "Git Status" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end,       desc = "Git Stash" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,        desc = "Git Diff (Hunks)" },
        -- search
        { '<leader>s/',      function() Snacks.picker.search_history() end,  desc = "Search History" },
        { "<leader>sa",      function() Snacks.picker.autocmds() end,        desc = "Autocmds" },
        { "<leader>sc",      function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sC",      function() Snacks.picker.commands() end,        desc = "Commands" },
        { "<leader>sH",      function() Snacks.picker.highlights() end,      desc = "Highlights" },
        { "<leader>si",      function() Snacks.picker.icons() end,           desc = "Icons" },
        { "<leader>sj",      function() Snacks.picker.jumps() end,           desc = "Jumps" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,         desc = "Keymaps" },
        { "<leader>sM",      function() Snacks.picker.man() end,             desc = "Man Pages" },
        { "<leader>sp",      function() Snacks.picker.lazy() end,            desc = "Search for Plugin Spec" },
        { "<leader>sq",      function() Snacks.picker.qflist() end,          desc = "Quickfix List" },
        { "<leader>su",      function() Snacks.picker.undo() end,            desc = "Undo History" },
        -- Other
        { "<leader>z",       function() Snacks.zen.zoom() end,               desc = "Toggle Zoom" },
        { "<leader>.",       function() Snacks.scratch() end,                desc = "Toggle Scratch Buffer" },
        { "<leader>S",       function() Snacks.scratch.select() end,         desc = "Select Scratch Buffer" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command
            end,
        })
    end,
}
