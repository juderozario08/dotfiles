vim.g.mapleader = " "

vim.keymap.set(
    "n",
    "<leader>e",
    ":Neotree action=focus source=filesystem float reveal toggle=true<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "<leader>E",
    ":Neotree action=focus source=buffers float reveal toggle=true<CR>",
    { noremap = true, silent = true }
)

vim.keymap.set("n", "H", [[mzO<ESC>j`z]], { noremap = true, silent = true })
vim.keymap.set("n", "L", [[mzo<ESC>k`z]], { noremap = true, silent = true })
vim.keymap.set("n", "<M-_>", ":horizontal resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-+>", ":horizontal resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-{>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-}>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-_>", ":only<CR>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<S-Tab>", [[mz<<<ESC>`zhhhh]], { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Tab>", [[mz>><ESC>`zllll]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("n", "<C-d>", "15jzz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "15kzz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

vim.keymap.set("x", "<leader>p", [["_dP]], { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "y", [["+y]], { noremap = true, silent = true })
vim.keymap.set("n", "yy", [["+Y]], { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ge", "oif err != nil {<CR>}<ESC>O", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { noremap = true, silent = true })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("i", "<C-t>", "<nop>")
vim.keymap.set("i", "<C-d>", "<nop>")
vim.keymap.set("i", "<C-c>", "<nop>")
vim.keymap.set("i", "<C-o>", "<nop>")
vim.keymap.set("n", "<leader>w", ":w!<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>s", [[mz:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { noremap = true, silent = true })

vim.keymap.set("v", '<leader>"', [[c"<ESC>pa"<ESC>]])
vim.keymap.set("v", "<leader>'", [[c'<ESC>pa'<ESC>]])
vim.keymap.set("v", "<leader>`", [[c`<ESC>pa`<ESC>]])
vim.keymap.set("v", "<leader>(", [[c(<ESC>pa)<ESC>]])
vim.keymap.set("v", "<leader>)", [[c(<ESC>pa)<ESC>]])
vim.keymap.set("v", "<leader>{", [[c{<ESC>pa}<ESC>]])
vim.keymap.set("v", "<leader>}", [[c{<ESC>pa}<ESC>]])
vim.keymap.set("v", "<leader>[", [[c[<ESC>pa]<ESC>]])
vim.keymap.set("v", "<leader>]", [[c[<ESC>pa]<ESC>]])

vim.keymap.set("n", '<leader>"', [[ciw"<ESC>pa"<ESC>]])
vim.keymap.set("n", "<leader>'", [[ciw'<ESC>pa'<ESC>]])
vim.keymap.set("n", "<leader>`", [[ciw`<ESC>pa`<ESC>]])
vim.keymap.set("n", "<leader>(", [[ciw(<ESC>pa)<ESC>]])
vim.keymap.set("n", "<leader>)", [[ciw(<ESC>pa)<ESC>]])
vim.keymap.set("n", "<leader>{", [[ciw{<ESC>pa}<ESC>]])
vim.keymap.set("n", "<leader>}", [[ciw{<ESC>pa}<ESC>]])
vim.keymap.set("n", "<leader>[", [[ciw[<ESC>pa]<ESC>]])
vim.keymap.set("n", "<leader>]", [[ciw[<ESC>pa]<ESC>]])
