-- Leader
vim.g.mapleader = " "

-- Behavior
vim.opt.mouse = nil
vim.opt.clipboard = 'unnamedplus'

-- Colors
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Indent
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = { 81 }
vim.opt.wrap = false

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Python
vim.g.python3_host_prog = '/usr/bin/python'
