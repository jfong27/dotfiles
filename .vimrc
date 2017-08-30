set expandtab
set tabstop=3
set softtabstop=3 
set shiftwidth=3

set si

set wildmenu
set lazyredraw

set hlsearch

:set mouse=a
set incsearch
set number

nnoremap j gj
nnoremap k gk

inoremap jk <esc>

colo default

imap ;print System.out.println();<left><left>

execute pathogen#infect()
syntax on
filetype plugin indent on


""Changes color of vim's error msg on bottom
""Like when you do :W instead of :w
:hi ErrorMsg term=standout ctermbg=8 ctermfg=11 

