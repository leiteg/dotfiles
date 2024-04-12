--[[
-- Navigate your code with search labels, enhanced character motions and
-- Treesitter integration.
--]]

local function _(name, opts)
    return function()
        require 'flash'[name](opts)
    end
end

return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "s", _ "jump", mode = { "n", "x", "o" }, desc = "Flash" },
        -- { "r",     _ "remote",            mode = { "o" },           desc = "Flash Remote" },
        -- { "R",     _ "treesitter_search", mode = { "o", "x" },      desc = "Flash Treesitter Search" },
        -- { "<c-s>", _ "toggle",            mode = { "c" },           desc = "Flash Toggle Search" },
        -- { "S",     _ "treesitter",        mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
    },
}
