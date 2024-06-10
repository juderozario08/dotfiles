return {
    "nvimtools/none-ls.nvim",
    lazy = false,
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.biome,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.tidy,
                null_ls.builtins.formatting.markdownlint,
                null_ls.builtins.formatting.mix,
                null_ls.builtins.formatting.stylelint,

                null_ls.builtins.completion.spell,
                null_ls.builtins.completion.tags,

                null_ls.builtins.code_actions.gomodifytags,
                null_ls.builtins.code_actions.impl,
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.code_actions.regal,
                null_ls.builtins.code_actions.statix,

                null_ls.builtins.diagnostics.actionlint,
                null_ls.builtins.diagnostics.cppcheck,
                null_ls.builtins.diagnostics.cmake_lint,
                null_ls.builtins.diagnostics.stylelint,
                null_ls.builtins.diagnostics.credo,
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.diagnostics.tidy,
                null_ls.builtins.diagnostics.todo_comments,
                null_ls.builtins.diagnostics.zsh,
            },
        })
    end,
}
