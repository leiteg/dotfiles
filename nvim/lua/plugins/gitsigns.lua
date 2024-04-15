--[[
-- Git integration for buffers.
--]]

local function _(name, opts)
    return function()
        require('gitsigns')[name](opts)
    end
end

return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    keys = {
        { "<leader>gs", _ "stage_hunk",        desc = "Gitsigns Hunk Stage" },
        { "<leader>gu", _ "undo_stage_hunk",   desc = "Gitsigns Hunk Stage Undo" },
        { "<leader>gr", _ "reset_hunk",        desc = "Gitsigns Hunk Reset" },
        { "<leader>gp", _ "preview_hunk",      desc = "Gitsigns Hunk Preview" },
        { "<leader>gt", _ "toggle_deleted",    desc = "Gitsigns Deleted" },
        { "<leader>gb", _ "blame_line",        desc = "Gitsigns Blame" },
        { "]h",         _("nav_hunk", "next"), desc = "Gitsigns Hunk Next" },
        { "[h",         _("nav_hunk", "prev"), desc = "Gitsigns Hunk Prev" },
    },
    opts = {
        -- Display sign column for staged hunks, with a dimer color.
        -- See: https://github.com/lewis6991/gitsigns.nvim/issues/788
        _signs_staged_enable = true,
    },
}
