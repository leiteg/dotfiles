--[[
-- Neovim plugin for a code outline window.
--]]
return {
    'stevearc/aerial.nvim',
    lazy = false,
    opts = {
        autojump = true,
        close_on_select = true,
        highlight_on_jump = false,
        show_guides = true,
        keymaps = {
            ["<esc>"] = "actions.close",
        },
        nav = {
            keymaps = {
                ["q"] = "actions.close",
                ["<esc>"] = "actions.close",
            },
        },
    },
    keys = {
        { "<leader>q", "<cmd>AerialToggle float<CR>", desc = "Aerial Toggle" },
        { "<leader>Q", "<cmd>AerialNavToggle<CR>",    desc = "Aerial Toggle Nav" },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
}
