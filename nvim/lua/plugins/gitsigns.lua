--[[
-- Git integration for buffers.
--]]

local function gitsigns(name, opts)
    return function()
        require('gitsigns')[name](opts)
    end
end

return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    keys = {
        { "<leader>gs", gitsigns("stage_hunk"),      desc = "Gitsigns stage hunk" },
        { "<leader>gu", gitsigns("undo_stage_hunk"), desc = "Gitsigns undo stage hunk" },
        { "<leader>gr", gitsigns("reset_hunk"),      desc = "Gitsigns reset hunk" },
        { "<leader>gt", gitsigns("toggle_deleted"),  desc = "Gitsigns toggle deleted lines" },
        { "<leader>gb", gitsigns("blame_line"),      desc = "Gitsigns blame line" },
        { "<leader>gp", gitsigns("preview_hunk"),    desc = "Gitsigns preview hunk" },
    },
    opts = {
        -- Display sign column for staged hunks, with a dimer color.
        -- See: https://github.com/lewis6991/gitsigns.nvim/issues/788
        _signs_staged_enable = true,
    },
}
