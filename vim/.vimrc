"""Indentation options"""
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4

"""Search options"""
set hlsearch
set incsearch
set smartcase "automatically switch search to case-sensitive when search query contains an uppercase letter

"""Text rendering options"""
"syntax enable
filetype plugin indent on
syntax on

"""User interface options"""
"set laststatus=2 "always display the status bar
set ruler
colorscheme peachpuff
set number
set mouse=a "enable mouse for scrolling and resizing
set title
"set background=dark
highlight Comment ctermfg=green


"Set file type for .launch files from ROS to XML
au BufRead,BufNewFile *.launch set filetype=xml
au BufRead,BufNewFile *.world set filetype=xml

