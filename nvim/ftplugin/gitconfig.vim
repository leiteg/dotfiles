setlocal foldmethod=expr
setlocal foldexpr=GitConfigFold(v:lnum)
setlocal fillchars=fold:\ 
setlocal foldtext=GitConfigText()

function! GitConfigFold(lnum)
  let line = getline(a:lnum)
  if line =~# '^\s*\[[^]]*\]'
    return '>1'
  endif
  return '='
endfunction

function! GitConfigText()
  let line = getline(v:foldstart)
  let nlines = v:foldend - v:foldstart
  let text = toupper(substitute(line, '\v^\[(.+)\]', '\1', 'g'))
  let fill = &textwidth - len(text) - len(nlines) - 7
  return '# ' . text . ' ' . repeat('.', fill) . ' (' . nlines . 'L)'
endfunction
