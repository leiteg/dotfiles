vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.conceallevel = 2
vim.bo.textwidth = 0
vim.bo.wrapmargin = 0

local set = vim.keymap.set

set("n", "j", "gj", { buffer = true })
set("n", "k", "gk", { buffer = true })
