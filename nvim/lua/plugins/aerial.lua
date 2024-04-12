--[[
-- Neovim plugin for a code outline window.
--]]

local function _(fn, opts)
    return function()
        require("aerial")[fn](opts)
    end
end

return {
    'stevearc/aerial.nvim',
    event = "VeryLazy",
    opts = {
        autojump = true,
        close_on_select = true,
        highlight_on_jump = false,
        show_guides = true,
        layout = {
            default_direction = "float",
        },
        keymaps = {
            ["<esc>"] = "actions.close",
        },
        nav = {
            autojump = true,
            keymaps = {
                ["q"] = "actions.close",
                ["<esc>"] = "actions.close",
            },
        },
    },
    keys = {
        { "<leader>q", _ "toggle",     desc = "Aerial Toggle" },
        { "<leader>Q", _ "nav_toggle", desc = "Aerial Toggle Nav" },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function(_, opts)
        require("aerial").setup(opts)
        require("telescope").load_extension("aerial")
    end
}
