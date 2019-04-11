" Indentation
" setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8

" cscope maps
nnoremap <buffer> <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <buffer> <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Include surround (TODO: Find a more elegant way)
let b:surround_{char2nr("i")} = "#include <\r.h>"
vnoremap <buffer> <leader>i :normal yssi<CR>
