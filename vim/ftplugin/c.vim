" Surround macro
let b:surround_{char2nr("i")} = "#include <\r.h>"
let b:surround_{char2nr("I")} = "#include <\r>"

" Surround mappings
vnoremap <buffer> <leader>i :normal yssi<CR>
vnoremap <buffer> <leader>I :normal yssI<CR>

" Cscope mappings
nnoremap <buffer> <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <buffer> <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Clang-format mapping
map <buffer> <C-K>      :py3file ~/dotfiles/scripts/clang-format.py<CR>
