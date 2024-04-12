--[[
-- The undo history visualizer for VIM.
--]]
return {
    "mbbill/undotree",
    lazy = true,
    cmd = "UndotreeToggle",
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndoTree Toggle" }
    },
}
