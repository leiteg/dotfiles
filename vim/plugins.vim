call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'             , { 'for': 'html' }
Plug 'APZelos/blamer.nvim'
Plug 'bfrg/vim-cpp-modern'            , { 'for': 'cpp' }
Plug 'cespare/vim-toml'
Plug 'dracula/vim'                    , { 'as': 'dracula.vim' }
Plug 'google/yapf'                    , { 'for': 'python', 'rtp': 'plugins/vim' }
Plug 'gregsexton/gitv'                , { 'on': ['Gitv'] }
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf'                   , { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'              , { 'on': ['Goyo'] }
Plug 'junegunn/gv.vim'                , { 'on': ['GV'] }
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'KeitaNakamura/tex-conceal.vim'  , { 'for': 'tex' }
Plug 'lervag/vimtex'
Plug 'lervag/wiki.vim'
Plug 'mateusbraga/vim-spell-pt-br'
Plug 'mattn/emmet-vim'                , { 'for': 'html' }
Plug 'mzlogin/vim-markdown-toc'       , { 'for': 'markdown' }
Plug 'neoclide/coc.nvim'              , { 'branch': 'release' }
Plug 'petrushka/vim-opencl'           , { 'for': 'opencl' }
Plug 'reedes/vim-pencil'
Plug 'rhysd/committia.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'rust-lang/rust.vim'             , { 'for': 'rust' }
Plug 'scrooloose/nerdtree'            , { 'on': ['NERDTreeToggleVCS'] }
Plug 'sirver/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'wellle/targets.vim'

" EXPERIMENTING {{{1

Plug 'pineapplegiant/spaceduck'     , { 'branch': 'main' }

" INACTIVE {{{1

" Plug 'airblade/vim-rooter'
" Plug 'klen/python-mode'               , { 'for': 'python', 'branch': 'develop' }
" Plug 'scrooloose/nerdcommenter'
" Plug 'voldikss/vim-floaterm'

" }}}

call plug#end()
