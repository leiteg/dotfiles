--[[
-- Add/change/delete surrounding delimiter pairs with ease. Written with ❤️ in Lua.
--]]
return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup {
            move_cursor = false,
            aliases = {
                -- Use `c` to surround text with function call.
                ["c"] = "f",
            },
        }
        vim.cmd [[ highlight link NvimSurroundHighlight IncSearch ]]
    end
}
