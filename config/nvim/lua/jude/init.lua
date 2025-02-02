require("jude.set")
require("jude.remap")
require("jude.lazy_init")
require("jude.php")
local augroup = vim.api.nvim_create_augroup
local jude = augroup("jude", {})
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

vim.o.timeoutlen = 500

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150,
        })
    end,
})

autocmd("LspAttach", {
    group = jude,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "C-s", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>fo", function()
            vim.lsp.buf.format()
            vim.cmd(":w")
        end, opts)
    end,
})

autocmd({ "BufWritePre" }, {
    group = jude,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- autocmd({ "VimEnter" }, {
--     group = jude,
--     pattern = "*",
--     command = [[Copilot disable]],
-- })

vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg = 'LightRed' })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
