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
Plugin 'terryma/vim-multiple-cursors'
Plugin 'joonty/vdebug'

call vundle#end()
filetype plugin indent on

" set the background to dark
set background=dark

" Get swap files out of my sight
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" syntax highlighting
syntax on

" numbered lines
set number
set numberwidth=1


" spell check, because I can't type
set spelllang=en
set spell

" search options
set incsearch
set hlsearch
set smartcase
set ignorecase

" limit myself to 80 chars
set colorcolumn=80

" tabs
set tabstop=4
set shiftwidth=4
set smarttab

" make special chars visible

if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
	let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
	let &fillchars = "vert:\u259a,fold:\u00b7"
else
	set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif

" cursor position
set ruler

" file name completion
set wildmenu
set wildmode=longest:full,full

" insert mode completion
set completeopt=longest,menuone,preview

" history
set history=200

" status line
set laststatus=2
set showcmd

" leave some space
set scrolloff=2

" experimental. Jump to bracket
set showmatch

" stop the beeping
set visualbell

" show the title
set title

" show the cursor line only in insert mode
augroup cline
    au!
	au winleave,insertenter * set cursorline
	au WinEnter,InsertLeave * set nocursorline
augroup END

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END


" Load local vimrc if present
if !empty(glob("~/.local.vimrc"))
	source ~/.local.vimrc
endif
