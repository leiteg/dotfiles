--[[
-- A file explorer tree for neovim written in lua.
--]]

local function _(fn, opts)
    return function()
        require("nvim-tree.api").tree[fn](opts)
    end
end

return {
    "nvim-tree/nvim-tree.lua",
    cmd = {
        "NvimTreeToggle",
        "NvimTreeFindFile",
    },
    keys = {
        { "<leader>e", _("toggle", { find_file = true }), desc = "NvimTree Toggle" },
    },
    opts = {
        filters = {
            git_ignored = false,
        },
        renderer = {
            icons = {
                git_placement = "signcolumn",
                glyphs = {
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "󱨧",
                        untracked = "",
                        deleted = "",
                        ignored = "",
                    },
                },
            },
        },
    },
}
