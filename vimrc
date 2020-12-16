" --------------------------------------------------------------------
"                            _
"                     _   __(_)___ ___  __________
"                    | | / / / __ `__ \/ ___/ ___/
"                   _| |/ / / / / / / / /  / /__
"                  (_)___/_/_/ /_/ /_/_/   \___/
"
"              Gustavo Leite <gustavoleite.ti@gmail.com>
"
" --------------------------------------------------------------------

" BASIC CONFIG {{{

" Enable filetype detection
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Set leader character
let mapleader = ","

" Set neovim specific config
if has('nvim')
  set runtimepath^=~/.vim
  set runtimepath^=~/.vim/after
  let &packpath = &runtimepath
endif

" }}}

" VIM-PLUG {{{

if !empty(glob('~/.vim/autoload/plug.vim')) && !empty(glob('~/.vim/plugins.vim'))
    source ~/.vim/plugins.vim
endif

" }}}

" EDITOR OPTIONS {{{

" General
set encoding=utf-8
set nocompatible
set title
set hlsearch incsearch
set ignorecase smartcase
set ruler
set showcmd
set showmatch
set history=200
set autoread
set autowrite
set gdefault
set laststatus=2
set backspace=indent,eol,start
set nofoldenable
set clipboard=unnamedplus
set listchars=tab:▸\ ,space:·
set exrc
set secure
set timeoutlen=500 ttimeoutlen=0

if !has('nvim')
  set noesckeys
endif

" Colorscheme
silent! colorscheme dracula
set background=dark
set t_Co=256

if has('termguicolors')
    set termguicolors
endif

" Splits
set splitbelow splitright

" Indent
set expandtab autoindent smartindent
set softtabstop=4 shiftwidth=4

" Wrapping
set nowrap textwidth=80

" Appearence
set cursorline colorcolumn=+1
set number relativenumber

" Folds
set foldenable foldmethod=marker

" Diffs
if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" Directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" }}}

" AUTO COMMANDS {{{

" General purpose
augroup AutoCommands
    autocmd!
    autocmd QuickFixCmdPost *             :copen
    autocmd BufWritePost .vimrc,vimrc     :source %

    " Jump to last location when opening a file
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif

augroup END

" Skeleton files
augroup Templates
    autocmd!
    autocmd BufNewFile *.*          silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e").' | normal Gddgg'
augroup END

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Highligh trailing whitespace
augroup TrailingWhitespace
    autocmd!
    autocmd BufWinEnter *           match ExtraWhitespace /\s\+$/
    autocmd InsertEnter *           match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave *           match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave *           call clearmatches()
augroup END

" }}}

" MAPPINGS {{{

inoremap jk             <esc>
inoremap JK             <esc>
inoremap Jk             <esc>
vnoremap J              :m '>+1<CR>gv
vnoremap K              :m '<-2<CR>gv
vnoremap >              >gv
vnoremap <              <gv
nnoremap <tab>          :bnext<CR>
nnoremap <s-tab>        :bprevious<CR>
nnoremap <leader>sr     :%s/\<<C-R><C-W>\>/
noremap  <F5>           :setlocal spell!<CR>
noremap  <space>        za
noremap  '              `
nnoremap /              /\v
nnoremap ?              ?\v

nnoremap <C-W>t         :vert term<CR>
nnoremap <C-W>T         :term<CR>

" Plugin: junegunn/vim-plug
nnoremap <leader>pc     :PlugClean<CR>
nnoremap <leader>pi     :PlugInstall<CR>
nnoremap <leader>pu     :PlugUpdate<CR>

" Plugin: junegunn/fzf.vim
nmap <C-P>              :Files<CR>
nmap g<C-P>             :GFiles<CR>
nmap <leader>gg         :Commits<CR>
nmap <leader>gb         :Buffers<CR>
nmap <leader>gl         :Lines<CR>
nmap <leader>gL         :BLines<CR>
nmap <leader>gt         :Tags<CR>
nmap <leader>gT         :BTags<CR>
nmap <leader>gh         :History<CR>

" Plugin: junegunn/vim-easy-align
nmap ga                 <Plug>(EasyAlign)
xmap ga                 <Plug>(EasyAlign)

" Plugin: tpope/vim-fugitive
nmap <leader>gs         :Gstatus<CR>
nmap <leader>gc         :Gcommit<CR>

" Plugin: preservim/nerdtree
nnoremap <C-Z>          :NERDTreeToggleVCS<CR>

" Disable
nnoremap <up>           <nop>
nnoremap <down>         <nop>
nnoremap <left>         <nop>
nnoremap <right>        <nop>
inoremap <up>           <nop>
inoremap <down>         <nop>
inoremap <left>         <nop>
inoremap <right>        <nop>
nnoremap q/             <nop>
nnoremap q:             <nop>

" Unused
" nmap <leader>q      :Colors<CR>
" nmap <leader>q      :Windows<CR>
" nmap <leader>q      :Locate<CR>
" nmap <leader>q      :Snippets<CR>
" nmap <leader>q      :Marks<CR>
" nmap <leader>q      :GFiles?<CR>
" nmap <leader>q      :BCommits<CR>
" nmap <leader>q      :Commands<CR>
" nmap <leader>q      :Maps<CR>
" nmap <leader>q      :Ag<CR>
" nmap <leader>q      :Rg<CR>
" nmap <leader>q      :History:<CR>
" nmap <leader>q      :History/<CR>
" nmap <leader>q      :Helptags<CR>
" nmap <leader>q      :Filetypes<CR>

command! Config       :tabnew | edit $MYVIMRC | vsplit ~/dotfiles/vim/plugins.vim | wincmd h

" }}}

" ABBREVS {{{

cnoreabbrev W   w
cnoreabbrev Wq  wq
cnoreabbrev WQ  wq
cnoreabbrev Sh  sh
cnoreabbrev SH  sh
cnoreabbrev Set set

" }}}

" PLUGINS CONFIGURATION {{{

" vim-airline/vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_min_count = 1
let g:airline#extensions#tabline#buffer = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
" }}}

" lervag/vimtex {{{
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'skim'
let g:vimtex_complete_close_braces = 1
let g:vimtex_compiler_latexmk = { 'callback': 0, 'build_dir': 'build' }
" }}}

" scroolose/NERDCommenter {{{
let NERDSpaceDelims = 1
" }}}

" mhinz/vim-signify {{{
let g:signify_disable_by_default = 1
let g:signify_line_highlight = 1
let g:signify_vcs_list = ['git']
hi SignColumn      ctermbg=0
" }}}

" kien/ctrlp {{{
let g:ctrlp_custom_ignore = '\.o$'
" }}}

" kana/vim-submode {{{
let g:submode_timeout = 0
" }}}

" SirVer/ultisnips {{{
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories = [ "snips" ]
let g:UltiSnipsExpandTrigger = "<c-l>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"
" }}}

" neoclide/coc.nvim {{{

set hidden
set nobackup
set nowritebackup
" set cmdheight=2

set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
"  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" }}}

" reedes/vim-pencil {{{

let g:pencil#autoformat = 1
let g:pencil#wrapModeDefault = 'hard'
let g:pencil#textwidth = 80

augroup pencil
    autocmd!
    autocmd FileType markdown,rst call pencil#init({'wrap': 'hard', 'textwidth': 80})
augroup END

" }}}

" voldikss/vim-floaterm {{{
nnoremap <leader>t :FloatermToggle<CR>
" }}}

" }}}
