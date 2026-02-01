return {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
        require('dap-go').setup {
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
        }
    end,
}
