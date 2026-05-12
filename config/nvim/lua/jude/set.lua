vim.opt.clipboard = "unnamedplus"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.guicursor = "n-v-i-sm:block"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "120"

vim.api.nvim_create_augroup('incsearch_highlight', { clear = true })

vim.api.nvim_create_autocmd('CmdlineEnter', {
    pattern = { '/', '?' },
    callback = function()
        vim.opt.hlsearch = true
    end,
    group = 'incsearch_highlight',
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
    pattern = { '/', '?' },
    callback = function()
        vim.opt.hlsearch = false
    end,
    group = 'incsearch_highlight',
})

vim.o.list = true
vim.o.listchars = 'tab:» ,space:.,precedes:<'
