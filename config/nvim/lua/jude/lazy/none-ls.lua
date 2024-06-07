return {
	"nvimtools/none-ls.nvim",
	lazy = false,
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Formatters
				-- C, C++, C#, and Java
				null_ls.builtins.formatting.clang_format,

				-- JavaScript, TypeScript, JSON, and more
				null_ls.builtins.formatting.biome,

				-- Python
				null_ls.builtins.formatting.black,

				-- Go
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.golines,

				-- HTML
				null_ls.builtins.formatting.tidy,

				-- Markdown
				null_ls.builtins.formatting.markdownlint,

				-- Other Languages
				null_ls.builtins.formatting.mix, -- Elixir
				null_ls.builtins.formatting.stylelint, -- CSS, SCSS, and other CSS-like syntaxes
				null_ls.builtins.formatting.treefmt, -- Multiple languages

				-- Completion
				null_ls.builtins.completion.luasnip,
				null_ls.builtins.completion.spell,
				null_ls.builtins.completion.tags,

				-- Code Actions
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.code_actions.impl,
				null_ls.builtins.code_actions.refactoring,
				null_ls.builtins.code_actions.regal,
				null_ls.builtins.code_actions.statix,

				-- Diagnostics
				null_ls.builtins.diagnostics.actionlint,

				-- Language: C/C++
				null_ls.builtins.diagnostics.cppcheck,

				-- Language: CMake
				null_ls.builtins.diagnostics.cmake_lint,

				-- Language: CSS/SCSS
				null_ls.builtins.diagnostics.stylelint,

				-- Language: Elixir
				null_ls.builtins.diagnostics.credo,

				-- Language: Go
				null_ls.builtins.diagnostics.golangci_lint,

				-- Markdown linters
				-- Language: Markdown
				null_ls.builtins.diagnostics.markdownlint,

				-- Language: Python
				null_ls.builtins.diagnostics.mypy,

				-- Language: Python
				null_ls.builtins.diagnostics.pylint,

				-- Language: HTML/XML
				null_ls.builtins.diagnostics.tidy,

				-- Language: Other
				null_ls.builtins.diagnostics.todo_comments,
				null_ls.builtins.diagnostics.zsh,
			},
		})
	end,
}
