" ttyz vimrc
"
" 25 Aug 2015. 12:00:16

let mapleader=","
let maplocalleader="\\"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap H ^
nnoremap L $

" No compatible mode
set nocompatible


" Hide the buffers without notifying me
set hidden

" Vundle {{{
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
Plugin 'mfukar/robotframework-vim'
" Plugin 'joonty/vdebug'
Plugin 'fatih/vim-go'
" Plugin 'joonty/vim-phpunitqf'
" }}}

call vundle#end()
filetype plugin indent on

" set the background to dark
set background=dark

" Get swap files out of my sight
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*
set wildignore+=*.png,*.jpg,*.otf,*.woff,*.jpeg,*.orig
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
set wildignore+=*.exe

" syntax highlighting
syntax on
let g:syntastic_javascript_checkers = ['jshint'] 

" numbered lines
set number
set numberwidth=1


" spell check, because I can't type
set spelllang=en
set spell

" search options {{{
set incsearch
set hlsearch
set smartcase
set ignorecase
" }}}

" limit myself to 80 chars
set colorcolumn=80

" tabs
set tabstop=4
set shiftwidth=4
set smarttab

set list

" make special chars visible {{{
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
	let &listchars = "tab:\u00b7 ,trail:\u2423,extends:\u276d,precedes:\u276c,nbsp:\u26ad"
	set fillchars+=vert:│
else
	set listchars=tab:.\ ,trail:_,extends:>,precedes:<
	set fillchars=""
endif
" }}}

" cursor position
set ruler

" file name completion
set wildmenu
set wildmode=longest:full,full

" insert mode completion
set completeopt=longest,menuone,preview

" history
set history=200

" status line {{{
set laststatus=2
set showcmd
set statusline=%f
set statusline+=%=
set statusline+=%y
" }}}

" leave some space
set scrolloff=2

" experimental. Jump to bracket
set showmatch

" stop the beeping
set visualbell

" show the title
set title

" show the cursor line only in insert mode {{{
augroup cline
    autocmd!
	autocmd winleave,insertenter * set cursorline
	autocmd WinEnter,InsertLeave * set nocursorline
augroup END
" }}}

" Make sure Vim returns to the same line when you reopen a file. {{{
augroup line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}

" Load local vimrc if present {{{
if !empty(glob("~/.local.vimrc"))
	nnoremap <leader>elv :vsplit ~/.local.vimrc<cr>
	nnoremap <leader>slv :source ~/.local.vimrc<cr>
	source ~/.local.vimrc
endif
" }}}

" make italic comments
highlight Comment cterm=italic,bold

" debugger options {{{
let g:vdebug_options= {
			\    "port" : 9000,
			\    "server" : '',
			\    "timeout" : 20,
			\    "on_close" : 'detach',
			\    "break_on_open" : 0,
			\    "ide_key" : '',
			\    "path_maps" : {},
			\    "debug_window_level" : 0,
			\    "debug_file_level" : 0,
			\    "debug_file" : "",
			\    "watch_window_style" : 'compact',
			\    "marker_default" : '|',
			\    "marker_closed_tree" : '▸',
			\    "marker_open_tree" : '▾',
			\    "continuous_mode" : 1
			\}

" }}}

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set lazyredraw

" Mouse options {{{
set mouse=a
set ttymouse=xterm2
" }}}

" Vimscript filetype settings {{{
augroup ft_vim
	autocmd!
	autocmd FileType vim setlocal foldlevelstart=0
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
