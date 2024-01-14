local telescope = require("telescope")
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            }
        }
    },
}

-- See :h telescope.builtin
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "g<C-P>", builtin.find_files, {})
vim.keymap.set("n", "<leader>ls", builtin.buffers, {})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>go", function()
    builtin.lsp_dynamic_workspace_symbols({
        ignore_symbols = "variable"
    })
end)
