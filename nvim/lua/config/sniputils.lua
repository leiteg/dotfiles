local M = {}

local ls = require("luasnip")
local f = ls.f
local s = ls.s
local fmta = require("luasnip.extras.fmt").fmta

M.snippet = function(trig, desc, pat, nodes, opts)
    if opts == nil then
        opts = {}
    end
    return s(vim.tbl_deep_extend("keep", {
        trig = trig,
        desc = desc,
    }, opts), fmta(pat, nodes), { stored = opts.stored })
end

M.regex_snippet = function(trig, desc, pat, nodes, opts)
    if opts == nil then
        opts = {}
    end
    return s(vim.tbl_deep_extend("keep", {
        trig = trig,
        desc = desc,
        regTrig = true,
    }, opts), fmta(pat, nodes))
end

M.inline_snippet = function(trig, desc, pat, nodes, opts)
    if opts == nil then
        opts = {}
    end
    return s(vim.tbl_deep_extend("keep", {
        trig = trig,
        desc = desc,
        wordTrig = false,
    }, opts), fmta(pat, nodes))
end

M.if_empty = function(index, true_value, false_value)
    return f(function(args)
        if args[1][1] == "" then
            return true_value
        end
        return false_value
    end, { index })
end

M.capture = function(index)
    return f(function(_, snip) return snip.captures[index] end)
end

return M
