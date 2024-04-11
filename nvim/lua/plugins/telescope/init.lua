--[[
-- Find, Filter, Preview, Pick. All lua, all the time.
--]]
return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
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

        local theme = require("telescope.themes").get_dropdown()

        local find_all_files = function()
            builtin.find_files(
                vim.tbl_deep_extend("keep", theme, {
                    hidden = true,
                    no_ignore = true,
                })
            )
        end

        local workspace_symbols = function()
            builtin.lsp_dynamic_workspace_symbols(
                vim.tbl_deep_extend("keep", theme, {
                    ignore_symbols = "variable",
                })
            )
        end

        local git_files = function()
            builtin.git_files(theme)
        end

        local buffers = function()
            builtin.buffers(theme)
        end

        local live_grep = function()
            builtin.live_grep(theme)
        end

        local diagnostics = function()
            builtin.diagnostics(theme)
        end

        local keymaps = {
            { "<leader>P",  git_files,         { desc = "Telescope Git Files", } },
            { "<leader>p",  find_all_files,    { desc = "Telescope All Files", } },
            { "<leader>ls", buffers,           { desc = "Telescope Buffers", } },
            { "<leader>lg", live_grep,         { desc = "Telescope Live Grep", } },
            { "<leader>ld", diagnostics,       { desc = "Telescope Diagnostics", } },
            { "<leader>go", workspace_symbols, { desc = "Telescope Symbols" } },
        }

        for _, keymap in ipairs(keymaps) do
            vim.keymap.set("n", keymap[1], keymap[2], keymap[3])
        end

        -- Used by `goolord/alpha-nvim`
        vim.api.nvim_create_user_command("TelescopeFiles", find_all_files, {})
    end,
}
