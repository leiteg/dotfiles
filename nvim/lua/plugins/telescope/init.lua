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
                prompt_prefix = "  > ",
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

        local _ = function(fn)
            if type(fn) == "function" then
                return fn
            end

            return function()
                builtin[fn](theme)
            end
        end


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

        local keymaps = {
            { "<leader>T",  _ "builtin",          { desc = "Telescope Pickers", } },
            { "<leader>P",  _ "git_files",        { desc = "Telescope Git Files", } },
            { "<leader>p",  _(find_all_files),    { desc = "Telescope All Files", } },
            { "<leader>ls", _ "buffers",          { desc = "Telescope Buffers", } },
            { "<leader>lg", _ "live_grep",        { desc = "Telescope Live Grep", } },
            { "<leader>ld", _ "diagnostics",      { desc = "Telescope Diagnostics", } },
            { "<leader>go", _(workspace_symbols), { desc = "Telescope Symbols" } },
        }

        for _, keymap in ipairs(keymaps) do
            vim.keymap.set("n", keymap[1], keymap[2], keymap[3])
        end

        -- Used by `goolord/alpha-nvim`
        vim.api.nvim_create_user_command("TelescopeFiles", find_all_files, {})

        vim.cmd [[
            highlight TelescopeBorder       guifg=#565f89
            highlight TelescopePromptBorder guifg=#565f89
            highlight TelescopePromptTitle  gui=bold guifg=#bb9af7
            highlight TelescopePromptPrefix gui=bold
            highlight TelescopePreviewTitle gui=bold guifg=#bb9af7
            highlight TelescopeMatching     gui=reverse
        ]]
    end,
}
