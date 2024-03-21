" Cscope mappings
nnoremap <buffer> <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <buffer> <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Clang-format mapping
map <buffer> <C-K>      :py3file ~/dotfiles/scripts/clang-format.py<CR>

setlocal path+=/usr/include/**,./include
setlocal commentstring=//\ %s
