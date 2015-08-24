" ttyz vimrc
"
" Thu, Aug 20, 2015  9:46:04 AM
"

" set the background to dark
set background=dark

" Get swap files out of my sight
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" syntax highlighting
syntax on

" Numbered lines
set number
set numberwidth=1

" No compatible mode
set nocompatible

" Spell check, because I can't type
set spelllang=en
set spell

" Search options
set incsearch
set hlsearch

" Limit myself to 80 chars
set colorcolumn=80

" Tabs
set tabstop=4
set shiftwidth=4
filetype plugin indent on

" Cursor position
set ruler

" File name completion
set wildmenu
