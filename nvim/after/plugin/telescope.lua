local builtin = require('telescope.builtin')

vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "g<C-P>", builtin.find_files, {})
vim.keymap.set("n", "<leader>ps", builtin.grep_string, {})

-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})