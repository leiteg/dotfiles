local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "q", function()
    vim.api.nvim_buf_delete(bufnr, {})
end, {
    buffer = bufnr,
    desc = "Close Git Blame"
})
