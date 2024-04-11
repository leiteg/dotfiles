--[[
-- Navigate your code with search labels, enhanced character motions and
-- Treesitter integration.
--]]

local function flash(name, opts)
    return function()
        require 'flash'[name](opts)
    end
end

return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "s",     flash("jump"),              mode = { "n", "x", "o" }, desc = "Flash" },
        -- { "r",     flash("remote"),            mode = { "o" },           desc = "Flash Remote" },
        -- { "R",     flash("treesitter_search"), mode = { "o", "x" },      desc = "Flash Treesitter Search" },
        -- { "<c-s>", flash("toggle"),            mode = { "c" },           desc = "Flash Toggle Search" },
        -- { "S",     flash("treesitter"),        mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
    },
}
