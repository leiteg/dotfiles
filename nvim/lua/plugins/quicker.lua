--[[
-- Improved UI and workflow for the Neovim quickfix.
--]]

local function _(fn, args)
    return function()
        require("quicker")[fn](args)
    end
end

return {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    opts = {
        constrain_cursor = false,
        keys = {
            { ">",    _ "expand",     desc = "Expand quickfix content" },
            { "<",    _ "collapse",   desc = "Collapse quickfix content" },
            { "q", "<cmd>cclose<CR>", desc = "Close quickfix" },
            -- FIXME: This should work by default. Problem is being caused by other plugin though.
            { "<CR>", "<cmd>.cc<CR>", desc = "Jump to error under the cursor" },
        },
    },
}
