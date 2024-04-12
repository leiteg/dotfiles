--[[
-- Add/change/delete surrounding delimiter pairs with ease. Written with ❤️ in Lua.
--]]
return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {
        move_cursor = false,
        aliases = {
            -- Use `c` to surround text with function call.
            ["c"] = "f",
        },
    },
    config = function(_, opts)
        require("nvim-surround").setup(opts)
        vim.cmd [[
            highlight link NvimSurroundHighlight IncSearch
        ]]
    end
}
