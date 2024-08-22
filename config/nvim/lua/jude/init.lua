require("jude.set")
require("jude.remap")
require("jude.lazy_init")
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
        vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>=", function()
            vim.lsp.buf.format()
            vim.api.nvim_command(":w")
        end, opts)
        vim.keymap.set("n", "<leader>fo", [[mzgg=G'z:w<CR>]], opts)
    end,
})

autocmd({ "BufWritePre" }, {
    group = jude,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({ "VimEnter" }, {
    group = jude,
    pattern = "*",
    command = [[Copilot disable]],
})

--[[ autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                                                    for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
    end,
}) ]]

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
