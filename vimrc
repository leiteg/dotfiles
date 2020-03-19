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
set clipboard=unnamed
set noesckeys
set listchars=tab:▸\ ,space:·
set exrc
set secure

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

" vim-airline/vim-airline
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

" lervag/vimtex
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'skim'
let g:vimtex_complete_close_braces = 1
let g:vimtex_compiler_latexmk = { 'callback': 0, 'build_dir': 'build' }

" scroolose/NERDCommenter
let NERDSpaceDelims = 1

" mhinz/vim-signify
let g:signify_disable_by_default = 1
let g:signify_line_highlight = 1
let g:signify_vcs_list = ['git']
hi SignColumn      ctermbg=0

" kien/ctrlp
let g:ctrlp_custom_ignore = '\.o$'

" kana/vim-submode
let g:submode_timeout = 0

let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories = [ "snips" ]
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

" }}}
