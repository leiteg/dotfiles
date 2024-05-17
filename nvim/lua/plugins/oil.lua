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
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Oil",
    keys = {
        { "-", _ "open_float", desc = "Oil" }
    },
    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
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
