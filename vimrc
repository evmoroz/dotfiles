" ttyz vimrc
"
" 25 Aug 2015. 12:00:16

noremap <LeftRelease> "+y<LeftRelease>

let mapleader="\\"
let maplocalleader="|"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap H ^
nnoremap L $

" Use non-linewise movewment
nnoremap k gk
nnoremap j gj

" Save some keystrokes
nnoremap ; :

" No compatible mode
set nocompatible


" Hide the buffers without notifying me
set hidden

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
set nospell

" search options {{{
set incsearch
set hlsearch
set smartcase
set ignorecase
" }}}

" limit myself to 120 chars
set colorcolumn=120

" tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

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

" Mappings {{{
" Use double leader to clear the highlighting of :set hlsearch.
nnoremap <leader><leader> :nohlsearch<cr>

nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <leader>cq :cclose<cr>
nnoremap <leader>oq :copen<cr>
" }}}

set lazyredraw
set nowrap

" Mouse options {{{
set mouse=a
if !has('nvim')
    set ttymouse=sgr
endif
" }}}

" Vimscript filetype settings {{{
augroup ft_vim
	autocmd!
	autocmd FileType vim setlocal foldlevelstart=0
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Ag grep {{{
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor\ --column
	set grepformat=%f:%l:%c%m
	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0

	command! -nargs=* -complete=file Ag :silent! :grep <args> | :copen | :redraw!
endif
" }}}

" Fix crontab editing on OS X
autocmd filetype crontab setlocal nobackup nowritebackup

" Load local vimrc if present {{{
if !empty(glob("~/.local/vimrc"))
	nnoremap <leader>elv :vsplit ~/.local/vimrc<cr>
	nnoremap <leader>slv :source ~/.local/vimrc<cr>
	source ~/.local/vimrc
endif
" }}}

" Befreind fugitive with asyncrun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

" Autoopen the quickfix
augroup vimrc
	autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
augroup END

" keep gutters open for ale
let g:ale_php_phpcs_standard = "~/dotfiles/phpcs.xml"
let g:ale_sign_column_always = 1


" True color and italics
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set completeopt-=preview

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <c-p> pumvisible() ? coc#refresh() : "\<c-p>"
inoremap <silent><expr> <c-n> pumvisible() ? coc#refresh() : "\<c-n>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nnoremap <leader>t :tabn<cr>
nnoremap <leader>T :tabp<cr>

" always show signcolumns
set signcolumn=yes

" Use `:Format` to format current buffer" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

set updatetime=300

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)
nmap <leader>r :CocCommand document.renameCurrentWord<CR>
" use normal command like `<leader>xi(`
nmap <leader>x  <Plug>(coc-cursors-operator)

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 2

nnoremap <leader>cp :pclose<cr>

let g:neodark#background = '#202020'
colorscheme neodark
highlight Comment cterm=italic

set updatetime=100

inoremap <leader>fn <C-r>=expand("%:t:r")<cr>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
