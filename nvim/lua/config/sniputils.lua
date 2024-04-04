local M = {}

local ls = require("luasnip")
local f = ls.f
local s = ls.s
local fmta = require("luasnip.extras.fmt").fmta

M.snippet = function(trig, desc, pat, nodes)
    return s({ trig = trig, desc = desc }, fmta(pat, nodes))
end


M.if_empty = function(index, true_value, false_value)
    return f(function(args)
        if args[1][1] == "" then
            return true_value
        end
        return false_value
    end, { index })
end

return M
