call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'             , { 'for': 'html' }
Plug 'dracula/vim'                    , { 'as': 'dracula.vim' }
Plug 'google/yapf'                    , { 'for': 'python', 'rtp': 'plugins/vim' }
Plug 'gregsexton/gitv'                , { 'on': ['Gitv'] }
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'                   , { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'              , { 'on': ['Goyo'] }
Plug 'junegunn/gv.vim'                , { 'on': ['GV'] }
Plug 'junegunn/vim-easy-align'
Plug 'klen/python-mode'               , { 'for': 'python', 'branch': 'develop' }
Plug 'lervag/vimtex'
Plug 'mateusbraga/vim-spell-pt-br'
Plug 'mattn/emmet-vim'                , { 'for': 'html' }
Plug 'petrushka/vim-opencl'           , { 'for': 'opencl' }
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
Plug 'wellle/targets.vim'

" This should be deleted soon
" Replace with tpope/vim-commentary
Plug 'scrooloose/nerdcommenter'

call plug#end()
