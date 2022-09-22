--------------------------------------------------------------------------------
--            __              __    _           __       __                   --
--           / /_____  __  __/ /_  (_)___  ____/ /____  / /_  ______ _        --
--          / //_/ _ \/ / / / __ \/ / __ \/ __  / ___/ / / / / / __ `/        --
--         / ,< /  __/ /_/ / /_/ / / / / / /_/ (__  ) / / /_/ / /_/ /         --
--        /_/|_|\___/\__, /_.___/_/_/ /_/\__,_/____(_)_/\__,_/\__,_/          --
--                  /____/                                                    --
--                                                                            --
--------------------------------------------------------------------------------

local util = require 'leiteg.util'
local map  = util.map
local nmap = util.nmap
local imap = util.imap
local vmap = util.vmap
local noop = util.noop

-- Disable
noop('<up>')
noop('<down>')
noop('<left>')
noop('<right>')

-- Leave inser mode
imap('jk', '<esc>')
imap('JK', '<esc>')
imap('Jk', '<esc>')
imap('jK', '<esc>')

-- Better search defaults
nmap('/', '/\\v')
nmap('?', '?\\v')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Movement
nmap('<tab>',     '<cmd>bnext<CR>')
nmap('<s-tab>',   '<cmd>bprevious<CR>')
nmap('<leader>h', '<cmd>wincmd h<CR>')
nmap('<leader>j', '<cmd>wincmd j<CR>')
nmap('<leader>k', '<cmd>wincmd k<CR>')
nmap('<leader>l', '<cmd>wincmd l<CR>')

-- Editing
vmap('>', '>gv')
vmap('<', '<gv')
vmap('Y', 'y$')

-- Complex
vim.cmd [[
    inoremap <C-P>              <C-G>u<esc>[s1z=`]a<C-G>u
    nnoremap <leader>sr         :%s/\<<C-R><C-W>\>/
    vnoremap <silent> <C-J>     :m '>+1<CR>gv=gv
    vnoremap <silent> <C-K>     :m '<-2<CR>gv=gv
    inoremap <silent> <C-J>     <esc>:m .+1<CR>==a
    inoremap <silent> <C-K>     <esc>:m .-2<CR>==a
]]

-- Folds
map(',', 'za')
map('\'', '`')

-- Function-key Fn
map('<F1>', function() vim.wo.list  = not vim.wo.list end)
map('<F2>', function() vim.wo.spell = not vim.wo.spell end)
map('<F7>', "<cmd>FZF ~/dotfiles<CR>")
map('<F8>', "<cmd>FZF ~/dotfiles/nvim<CR>")
map('<F9>', "<cmd>FZF ~/life<CR>")
