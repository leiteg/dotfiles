local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

vim.keymap.set("n", "<leader>pq", vim.cmd.Lex)

-- Netrw Mappings
augroup("NetrwMappings", {clear = true})
autocmd("FileType", {
    pattern = "netrw",
    group = "NetrwMappings",
    callback = function()
        vim.keymap.set("n", "<c-n>", "<Plug>NetrwOpenFile", {buffer = true, noremap = true})
    end
})
