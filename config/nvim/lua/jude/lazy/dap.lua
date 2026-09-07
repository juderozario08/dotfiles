return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                opts = {},
                config = function(_, opts)
                    local dap = require("dap")
                    local dapui = require("dapui")
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open({})
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close({})
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close({})
                    end
                end,
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = "mason.nvim",
                cmd = { "DapInstall", "DapUninstall" },
                opts = {
                    automatic_installation = true,
                    handlers = {},
                    ensure_installed = {
                        "delve",
                    },
                },
            },
            {
                "leoluz/nvim-dap-go",
                opts = {
                    dap_configurations = {},
                    delve = {
                        path = "dlv",
                        initialize_timeout_sec = 20,
                        port = "${port}",
                        args = {},
                        build_flags = {},
                        detached = vim.fn.has("win32") == 0,
                        cwd = nil,
                    },
                    tests = {
                        verbose = false,
                    },
                },
            },
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue / Start Debugging" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate Debugging" },
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle DAP UI" },
            { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
        },
    },
}
