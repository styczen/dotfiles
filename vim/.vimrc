" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Common settings
filetype plugin indent on
syntax on
set number
set relativenumber
set hlsearch
set incsearch
set ignorecase
set smartcase
set expandtab
set tabstop=4
set shiftwidth=4
"set spell
"set ruler

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'bfrg/vim-cpp-modern'
call plug#end()

" Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1
