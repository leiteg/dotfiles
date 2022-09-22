setlocal spell spelllang=en,pt sts=2 sw=2 conceallevel=2

highlight SpellBad cterm=bold ctermfg=13
highlight Conceal ctermbg=none

nnoremap <buffer> K         gwap
nnoremap <buffer> <C-T>     :call vimtex#fzf#run('itc')<cr>

"call SetupBreakUndoOnPunctuation()

" KeitaNakamura/tex-conceal.vim {{{
let g:tex_conceal='abdmg'
" }}}
