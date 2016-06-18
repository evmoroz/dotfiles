wincmd n
set nowrap
wincmd w
set ft=sql
let @p="maggyG:wincmd w\nggdG\"0P:%!mysql -tu root -ps d\n:wincmd w\n\`a"
:nnoremap <Space> @p
