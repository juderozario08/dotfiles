local client = vim.lsp.start_client({
    name = "intelephense",
    cmd = { "intelephense", "--stdio" }
})

if client then
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "php",
        callback = function()
            vim.lsp.buf_attach_client(0, client)
        end
    })
end
