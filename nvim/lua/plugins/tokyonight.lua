--[[
-- A clean, dark Neovim theme written in Lua, with support for lsp, treesitter
-- and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm
-- and Fish.
--]]
return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("tokyonight-night")
    end,
}
