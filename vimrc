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

" {{{
"
" Enable filetype detection
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Set leader character
let mapleader = ","

" }}}

" VIM-PLUG {{{

if !empty(glob('~/.vim/autoload/plug.vim'))

    call plug#begin('~/.vim/plugged')

    Plug 'alvan/vim-closetag'             , { 'for': 'html' }
    Plug 'dracula/vim'                    , { 'as': 'dracula.vim' }
    Plug 'godlygeek/tabular'
    Plug 'google/yapf'                    , { 'for': 'python', 'rtp': 'plugins/vim' }
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf'                   , { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/gv.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'klen/python-mode'               , { 'for': 'python', 'branch': 'develop' }
    Plug 'lervag/vimtex'
    Plug 'mateusbraga/vim-spell-pt-br'
    Plug 'mattn/emmet-vim'                , { 'for': 'html' }
    Plug 'mhinz/vim-signify'
    Plug 'petRUShka/vim-opencl'           , { 'for': 'opencl' }
    Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'wellle/targets.vim'

    call plug#end()

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

" Colorscheme
silent! colorscheme dracula
set termguicolors
set background=dark
set t_Co=256

" Splits
set splitbelow splitright

" Indent
set expandtab autoindent smartindent
set softtabstop=4 shiftwidth=4

" Wrapping
set nowrap textwidth=80

" Appearence
set cursorline colorcolumn=81
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
    autocmd QuickFixCmdPost *       :copen
    autocmd BufWritePost .vimrc     :source %
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
"
noremap <F5>        :setlocal spell!<CR>

inoremap jk         <esc>
inoremap JK         <esc>
inoremap Jk         <esc>

nnoremap '          `

vnoremap <tab>      >gv
vnoremap <s-tab>    <gv

nnoremap <tab>      :bnext<CR>
nnoremap <s-tab>    :bprevious<CR>

nnoremap <leader>sr *N:%s/<C-R>//

nnoremap <space>    za
vnoremap <space>    za

vnoremap J          :m '>+1<CR>gv=gv
vnoremap K          :m '<-2<CR>gv=gv

" junegunn/fzf.vim
nmap <leader>f      :GFiles<CR>
nmap <C-p>          :Files<CR>
nmap <leader>b      :Buffers<CR>
nmap <leader>h      :History<CR>
nmap <leader>t      :BTags<CR>
nmap <leader>T      :Tags<CR>
nmap <leader>l      :BLines<CR>
nmap <leader>L      :Lines<CR>
nmap <leader>m      :Marks<CR>
nmap <leader>H      :Helptags!<CR>
nmap <leader>C      :Commands<CR>
nmap <leader>:      :History:<CR>
nmap <leader>/      :History/<CR>
nmap <leader>M      :Maps<CR>
nmap <leader>s      :Filetypes<CR>
" nmap <leader>a      :Ag<CR>
" nmap <leader>r      :Rg<CR>

" Disable
nnoremap q/         <nop>
nnoremap q:         <nop>
nnoremap <up>       <nop>
nnoremap <down>     <nop>
nnoremap <left>     <nop>
nnoremap <right>    <nop>
inoremap <up>       <nop>
inoremap <down>     <nop>
inoremap <left>     <nop>
inoremap <right>    <nop>

" }}}

" ABBREVS {{{

cnoreabbrev W   w
cnoreabbrev Wq  wq
cnoreabbrev WQ  wq
cnoreabbrev Sh  sh
cnoreabbrev SH  sh
cnoreabbrev Set set
"
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
let g:vimtex_compiler_latexmk = {'callback': 0}

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
"
" }}}
