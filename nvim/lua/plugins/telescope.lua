local plugins = {}

table.insert(plugins, {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                },
            },
        })

        -- See :h telescope.builtin
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope Git Files", })
        vim.keymap.set("n", "g<C-P>", builtin.find_files, { desc = "Telescope All Files", })
        vim.keymap.set("n", "<leader>ls", builtin.buffers, { desc = "Telescope Buffers", })
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope Live Grep", })
        vim.keymap.set("n", "<leader>td", builtin.diagnostics, { desc = "Telescope Diagnostics", })
        vim.keymap.set("n", "<leader>go", function()
            builtin.lsp_dynamic_workspace_symbols({ ignore_symbols = "variable" })
        end, { desc = "Telescope Symbols" })
    end,
})

table.insert(plugins, {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
        require("telescope").setup {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        }
        require("telescope").load_extension("fzf")
    end
})

return plugins
