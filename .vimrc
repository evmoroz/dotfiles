" ttyz vimrc
"
" 25 Aug 2015. 12:00:16

" No compatible mode
set nocompatible

" Hide the buffers without notifying me
set hidden

" Vundle
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on

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

" Make special chars visible by default
set list
set listchars=tab:▸\ ,eol:¬

" Cursor position
set ruler

" File name completion
set wildmenu
