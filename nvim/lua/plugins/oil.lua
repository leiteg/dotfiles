--[[
-- Neovim file explorer: edit your filesystem like a buffer.
--]]

local function _(fn, opts)
    return function()
        require("oil")[fn](opts)
    end
end

return {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Oil",
    keys = {
        { "-", _ "open_float", desc = "Oil" }
    },
    opts = {
        float = {
            padding = 5,
            max_width = 60,
            max_height = 25,

        },
        keymaps = {
            ["<esc>"] = "actions.close",
            ["q"] = "actions.close",
        },
    },
}
