" let g:gruvbox_italic=1
" colorscheme gruvbox
"

let g:neodark#background = '#202020'
colorscheme neodark
highlight Comment cterm=italic

hi default DbgBreakptLine term=reverse ctermfg=White ctermbg=Green guifg=#ffffff guibg=#003300
hi default DbgBreakptSign term=reverse ctermfg=White ctermbg=Green guifg=#ffffff guibg=#003300

function! PhpStormFormatter()
    write!
    AsyncRun -post=e /opt/PhpStorm-173.4548.32/bin/format.sh % 
endfunction

let g:vdebug_options['server'] = "172.17.0.1"
let g:vdebug_options['port'] = "9000"
let g:vdebug_options['path_maps'] = {"/app": "/home/emorozov/work/emailmarketing-api/app/"}

let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

set updatetime=100

inoremap <leader>fn <C-r>=expand("%:t:r")<cr>

set path+=/usr/lib/avr/include

packadd lh-vim-lib
packadd local_vimrc
" Remove $HOME from the asklist,
call lh#local_vimrc#filter_list('asklist', 'v:val != $HOME')
" Add it in the sandbox list instead
call lh#local_vimrc#munge('whitelist', $HOME."/work")

" let g:lsc_server_commands = {"php": "php ~/.composer/vendor/bin/php-language-server.php"}
" let g:lsc_server_commands = {"php": "phan --language-server-on-stdin"}

let g:vim_markdown_conceal = 2

let g:ale_completion_enabled = 0
let g:ale_set_balloons = 0
let g:ale_use_global_executables = 1

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': '?'}

set signcolumn=yes

nnoremap <leader>cp :pclose<cr>


augroup __make
    autocmd!
    au BufNewFile,BufRead */ext/{makefiles,presets}/* set ft=make
augroup END
augroup __php
    autocmd!
    autocmd BufNewFile *.php :call append(0,"<?php")
augroup END

augroup __docker
    autocmd!
    au BufNewFile,BufRead Dockerfile-* set ft=dockerfile
    au BufNewFile /tmp/dockerimages setlocal buftype=nofile
    au BufNewFile /tmp/dockerimages
                \ execute("%!docker images")
    au BufNewFile /tmp/dockerimages
                \ nnoremap <leader>q 0ma2W:AsyncRun docker rmi --force <cword><CR>:%!docker images<cr>'a
augroup END


set completeopt-=preview

" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"             \ <SID>check_back_space() ? "\<TAB>" :
"             \ coc#refresh()
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

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
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
