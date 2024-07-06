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
vim.keymap.set("n", "<M-_>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-+>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-_>", ":only<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

vim.keymap.set("x", "<leader>p", [["_dP]], { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "y", [["+y]], { noremap = true, silent = true })
vim.keymap.set("n", "yy", [["+Y]], { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { noremap = true, silent = true })

vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>w", ":w!<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { noremap = true, silent = true })
