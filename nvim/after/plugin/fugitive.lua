vim.keymap.set("n", "<leader><leader>", vim.cmd.Git, {
    desc = "Fugitive Status"
})
vim.keymap.set("n", "<leader>gc", "<cmd>tab Git commit<CR>", {
    desc = "Fugitive Commit"
})
vim.keymap.set("n", "<leader>gr", "<cmd>tab Git diff --staged<CR>", {
    desc = "Fugitive Review"
})
vim.keymap.set("n", "<leader>gd", "<cmd>tab Git diff<CR>", {
    desc = "Fugitive Diff"
})
vim.keymap.set("n", "<leader>gl", "<cmd>tab Git log --oneline<CR>", {
    desc = "Fugitive Log"
})
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", {
    desc = "Fugitive Blame"
})
