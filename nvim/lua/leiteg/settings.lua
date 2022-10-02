--------------------------------------------------------------------------------
--                        __  __  _                    __                     --
--             ________  / /_/ /_(_)___  ____ ______  / /_  ______ _          --
--            / ___/ _ \/ __/ __/ / __ \/ __ `/ ___/ / / / / / __ `/          --
--           (__  )  __/ /_/ /_/ / / / / /_/ (__  ) / / /_/ / /_/ /           --
--          /____/\___/\__/\__/_/_/ /_/\__, /____(_)_/\__,_/\__,_/            --
--                                    /____/                                  --
--                                                                            --
--------------------------------------------------------------------------------

local set = vim.opt
local g = vim.g

-- General Behavior
set.encoding = 'utf-8'
set.backspace = 'indent,eol,start'
set.clipboard = 'unnamedplus'
set.autoread = true
set.autowrite = true
set.timeoutlen = 500
set.ttimeoutlen = 0
set.exrc = true
set.secure = true
set.mouse = nil

-- Colorscheme
set.background = 'dark'
set.termguicolors = true

-- Splits
set.splitbelow = true
set.splitright = true

-- Indent
set.expandtab = true
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

-- Wrapping
set.wrap = false
set.textwidth = 80

-- Appearence
set.laststatus = 2
set.showcmd = true
set.showmatch = true
set.cursorline = true
set.colorcolumn = ''
set.number = true
set.relativenumber = true
set.listchars = { tab = '▸ ', space = '·', eol = '¶', trail = ';' }
set.ruler = true
set.title = true

-- Folds
set.foldenable = true
set.foldmethod = 'marker'

-- Diff options
set.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'

-- History
set.history = 200
set.undofile = true
set.swapfile = true
set.backup = false

-- Search
set.hlsearch = true
set.incsearch = true
set.gdefault = true
set.ignorecase = true
set.smartcase = true

-- Completion
set.completeopt = 'menu,menuone,noselect'

-- Leader
g.mapleader = ' '
