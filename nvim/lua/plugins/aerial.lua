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
    },
    keys = {
        { "<leader>q", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" }
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
}
