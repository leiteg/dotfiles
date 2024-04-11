--[[
-- Neovim plugin for splitting/joining blocks of code.
--]]
return {
    "Wansmer/treesj",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Toggle block/line" },
    },
    opts = {
        use_default_keymaps = false,
    },
}
