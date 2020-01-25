call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'             , { 'for': 'html' }
Plug 'dracula/vim'                    , { 'as': 'dracula.vim' }
Plug 'google/yapf'                    , { 'for': 'python', 'rtp': 'plugins/vim' }
Plug 'gregsexton/gitv'                , { 'on': ['Gitv'] }
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'                   , { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'klen/python-mode'               , { 'for': 'python', 'branch': 'develop' }
Plug 'lervag/vimtex'
Plug 'mateusbraga/vim-spell-pt-br'
Plug 'mattn/emmet-vim'                , { 'for': 'html' }
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'petRUShka/vim-opencl'           , { 'for': 'opencl' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'            , { 'on': ['NERDTreeToggleVCS'] }
Plug 'SirVer/Ultisnips'
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
