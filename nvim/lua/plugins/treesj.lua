--[[
-- Neovim plugin for splitting/joining blocks of code.
--]]

local function _(fn)
    return function()
        require("treesj")[fn]()
    end
end

return {
    "Wansmer/treesj",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>m", _ "toggle", desc = "Treesj Toggle" },
    },
    opts = {
        use_default_keymaps = false,
    },
}
