return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-a>"] = actions.toggle_all,
                    },
                },
            },
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ["<C-d>"] = actions.delete_buffer,
                        },
                    },
                },
            },
        })

        local find_all_files = function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end

        local workspace_symbols = function()
            builtin.lsp_dynamic_workspace_symbols({ ignore_symbols = "variable" })
        end

        -- See :h telescope.builtin
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope Git Files", })
        vim.keymap.set("n", "g<C-P>", find_all_files, { desc = "Telescope All Files", })
        vim.keymap.set("n", "<leader>p", find_all_files, { desc = "Telescope All Files", })
        vim.keymap.set("n", "<leader>ls", builtin.buffers, { desc = "Telescope Buffers", })
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope Live Grep", })
        vim.keymap.set("n", "<leader>td", builtin.diagnostics, { desc = "Telescope Diagnostics", })
        vim.keymap.set("n", "<leader>go", workspace_symbols, { desc = "Telescope Symbols" })
    end,
}
