vim.keymap.set("n", "<leader><leader>", vim.cmd.Git)
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>Git review<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>Git diff<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>Git log --oneline<CR>")