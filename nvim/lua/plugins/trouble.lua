--[[
-- A pretty diagnostics, references, telescope results, quickfix and location
-- list to help you solve all the trouble your code is causing.
--]]
return {
    "folke/trouble.nvim",
    cmd = {
        "Trouble",
        "TroubleToggle",
    },
    keys = {
        { "<leader>t", "<cmd>TroubleToggle<CR>", desc = "Toggle Trouble" }
    }
}
