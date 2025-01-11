set mouse=a
let mapleader = " "

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :Ex<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader><leader> :so %<CR>
nnoremap <leader>fo mzgg0=G`z
nnoremap H mzO<ESC>`z
nnoremap L mzo<ESC>`z
nnoremap J mz
nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz

set linebreak

set autowrite
set autowriteall
set autoread

set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,longest,preview

set relativenumber
set number
set nocul
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set incsearch
set rtp+=/opt/homebrew/opt/fzf

set backspace=indent,eol,start

filetype plugin indent on

syntax enable
