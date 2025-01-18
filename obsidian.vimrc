" ----------------------------------------------------------------------------
" BASIC
" ----------------------------------------------------------------------------

nnoremap jk <esc>
nnoremap j gj
nnoremap k gk

set clipboard=unnamed

" ----------------------------------------------------------------------------
" CUSTOM COMMANDS
" ----------------------------------------------------------------------------

exmap back    obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

exmap vsplit  obcommand workspace:split-vertical
exmap split   obcommand workspace:split-horizontal
exmap close   obcommand workspace:close
exmap bd      obcommand workspace:close
exmap daily   obcommand daily-notes
exmap prev    obcommand daily-notes:goto-prev
exmap next    obcommand daily-notes:goto-next

nmap <CR> gf

" ----------------------------------------------------------------------------
" SURROUND
" ----------------------------------------------------------------------------

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

nunmap S
vunmap S
map [[ :surround_wiki<CR>
map S" :surround_double_quotes<CR>
map S' :surround_single_quotes<CR>
map S` :surround_backticks<CR>
map Sb :surround_brackets<CR>
map S( :surround_brackets<CR>
map S) :surround_brackets<CR>
map S[ :surround_square_brackets<CR>
map S] :surround_square_brackets<CR>
map S{ :surround_curly_brackets<CR>
map S} :surround_curly_brackets<CR>
