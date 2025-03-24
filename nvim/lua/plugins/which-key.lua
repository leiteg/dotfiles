--[[
-- Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that
-- displays a popup with possible keybindings of the command you started typing.
--]]

local function show_local()
    require("which-key").show({})
end

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").add({
            { "<leader>d", group = "Debug" },
            { "<leader>g", group = "Git" },
            { "<leader>o", group = "Obsidian" },
        })
    end,
    keys = {
        { "<leader>?", show_local, desc = "Whichkey Show Local Mappings" },
    },
    opts = {}
}
