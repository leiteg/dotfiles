--------------------------------------------------------------------------------
--           __                                           __                  --
--          / /_____  __  ______ ___  ____ _____  _____  / /_  ______ _       --
--         / //_/ _ \/ / / / __ `__ \/ __ `/ __ \/ ___/ / / / / / __ `/       --
--        / ,< /  __/ /_/ / / / / / / /_/ / /_/ (__  ) / / /_/ / /_/ /        --
--       /_/|_|\___/\__, /_/ /_/ /_/\__,_/ .___/____(_)_/\__,_/\__,_/         --
--                 /____/               /_/                                   --
--                                                                            --
--------------------------------------------------------------------------------

-- Search
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Editing
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", "<cmd>m '<-2<CR>gv=gv")

-- Movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<tab>", "<cmd>bn<CR>")
vim.keymap.set("n", "<s-tab>", "<cmd>bp<CR>")

-- Insert mode
vim.keymap.set("i", "jk", "<esc>")

-- Quickfix
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

-- Misc
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Change sessions
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Terminal
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
