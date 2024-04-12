--[[
-- A pretty diagnostics, references, telescope results, quickfix and location
-- list to help you solve all the trouble your code is causing.
--]]

local function _(fn)
    return function()
        require("trouble")[fn]()
    end
end

return {
    "folke/trouble.nvim",
    cmd = {
        "Trouble",
        "TroubleToggle",
    },
    keys = {
        { "<leader>t", _ "toggle", desc = "Trouble Toggle" }
    }
}
