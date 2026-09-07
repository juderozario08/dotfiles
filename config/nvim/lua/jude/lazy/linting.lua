return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    opts = {
        linters_by_ft = {
            -- Configure linters per filetype here as needed, e.g.:
            -- javascript = { "eslint_d" },
            -- typescript = { "eslint_d" },
            -- markdown = { "markdownlint" },
        },
    },
    config = function(_, opts)
        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft or {}

        local function do_lint()
            local names = lint._resolve_linter_by_ft(vim.bo.filetype)
            if #names == 0 then
                return
            end
            lint.try_lint()
        end

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("jude_nvim_lint", { clear = true }),
            callback = do_lint,
        })
    end,
}
