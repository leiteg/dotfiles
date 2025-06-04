--[[
-- Show code context.
--]]

local function goto_context()
    require("treesitter-context").go_to_context(vim.v.count1)
end

return {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
        max_lines = 3,
    },
    keys = {
        { "[c", goto_context, desc = "Go to context" },
    },
}
