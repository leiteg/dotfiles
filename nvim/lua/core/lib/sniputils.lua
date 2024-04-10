local M = {}

--------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------

-- Luasnip
local ls = require("luasnip")
local f = ls.f
local s = ls.s
local fmta = require("luasnip.extras.fmt").fmta
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix

-- Treesitter
local ts_utils = require("nvim-treesitter.ts_utils")
local ts_locals = require("nvim-treesitter.locals")

--------------------------------------------------------------------------------
-- SNIPPET DEFINITION
--------------------------------------------------------------------------------

-- Improved API for defining snippets.
M.snippet = function(trig, desc, pat, nodes, opts)
    opts = opts or {}

    return s(
        vim.tbl_deep_extend("keep", {
            trig = trig,
            desc = desc,
        }, opts),
        fmta(pat, nodes),
        { stored = opts.stored, key = opts.key }
    )
end

-- Improved API for defining regex snippets.
M.regex_snippet = function(trig, desc, pat, nodes, opts)
    opts = opts or {}

    return M.snippet(
        trig,
        desc,
        pat,
        nodes,
        vim.tbl_deep_extend("keep", { regTrig = true }, opts)
    )
end

-- Improved API for defining word (inline) snippets.
M.inline_snippet = function(trig, desc, pat, nodes, opts)
    opts = opts or {}

    return M.snippet(
        trig,
        desc,
        pat,
        nodes,
        vim.tbl_deep_extend("keep", { wordTrig = true }, opts)
    )
end

-- Factory function that returns a treesitter_postfix snippet creator.
M.treesitter_snippet_factory = function(lang)
    return function(trig, query, pat, nodes, opts)
        opts = opts or {}
        return treesitter_postfix(
            vim.tbl_deep_extend("keep", {
                trig = trig,
                matchTSNode = {
                    query = query,
                    query_lang = lang,
                },
            }, opts),
            fmta(pat, nodes),
            { stored = opts.stored, key = opts.key }
        )
    end
end

--------------------------------------------------------------------------------
-- MISCELLANEOUS FUNCTIONS
--------------------------------------------------------------------------------

M.ts_is_inside = function(type)
    local node = ts_utils.get_node_at_cursor()

    if node == nil then
        return false
    end

    local scope = ts_locals.get_scope_tree(node, 0)
    for _, current in ipairs(scope) do
        if current:type() == type then
            return true
        end
    end

    return false
end

--------------------------------------------------------------------------------
-- CUSTOM NODES
--------------------------------------------------------------------------------

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
