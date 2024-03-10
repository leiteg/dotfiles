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
vim.keymap.set("n", "<C-p>", builtin.git_files, {
    desc = "Telescope Git Files",
})
vim.keymap.set("n", "g<C-P>", builtin.find_files, {
    desc = "Telescope All Files",
})
vim.keymap.set("n", "<leader>ls", builtin.buffers, {
    desc = "Telescope Buffers",
})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {
    desc = "Telescope Live Grep",
})
vim.keymap.set("n", "<leader>td", builtin.diagnostics, {
    desc = "Telescope Diagnostics",
})
vim.keymap.set("n", "<leader>go", function()
    builtin.lsp_dynamic_workspace_symbols({
        ignore_symbols = "variable"
    })
end, { desc = "Telescope Symbols" })
