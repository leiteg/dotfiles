--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("config.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATIONS
--------------------------------------------------------------------------------

local snippet = utils.snippet
local if_empty = utils.if_empty

local t = ls.t
local c = ls.c
local i = ls.i
local f = ls.f
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local ts_utils = require("nvim-treesitter.ts_utils")
local ts_locals = require("nvim-treesitter.locals")


--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

local function assign_list(index, opts)
    local function generate(args)
        local result = {}
        for arg in string.gmatch(args[1][1], '([^,]+)') do
            if arg ~= " " and not arg:find("*") then
                local name = arg:match("([^%s:]+).*")
                table.insert(result, string.format("    self.%s = %s", name, name))
            end
        end

        return sn(nil, t(result))
    end

    return d(index, generate, { opts.from })
end

local function is_inside_class()
    local node = ts_utils.get_node_at_cursor()

    if node ~= nil then
        local scope = ts_locals.get_scope_tree(node, 0)
        for _, current in ipairs(scope) do
            if current:type() == "class_definition" then
                return true
            end
        end
    end

    return false
end

local function self(from)
    return f(function(args)
        if is_inside_class() then
            if args[1][1] ~= "" then
                return "self, "
            end
            return "self"
        end
        return ""
    end, { from }, {})
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet("#!", "Shebang", [[
        #!/usr/bin/env python3

        <s>
    ]], { s = i(0) }),

    snippet(";impl", "Not Implemented", "raise NotImplementedError()", {}),

    snippet(";q", "Exit", "raise SystemExit(<code>)", {
        code = i(1, "0"),
    }),

    snippet(";main", "Entry point", [[
        if __name__ == "__main__":
            <body>
    ]], {
        body = i(1, "pass"),
    }),

    snippet(";h1", "Header 1", [[
        # ==============================================================================
        # <>
        # ==============================================================================
    ]], { i(1, "Header"), }),

    snippet(";h2", "Header 2", [[
        # ------------------------------------------------------------------------------
        # <text>
        # ------------------------------------------------------------------------------
    ]], { i(1, "Header"), }),

    -- Printing & Logging
    snippet(";p", "Print", "print(<>)", { i(1, "message") }),
    snippet(";log", "Info", 'log.info(<>)', { i(1, "message") }),
    snippet(";deb", "Debug", 'log.debug(<>)', { i(1, "message") }),
    snippet(";info", "Info", 'log.info(<>)', { i(1, "message") }),
    snippet(";warn", "Warn", 'log.warning(<>)', { i(1, "message") }),
    snippet(";err", "Error", 'log.error(<>)', { i(1, "message") }),

    snippet(";doc", "Docstring", [[
        """<>"""
        <>
    ]], {
        i(1, "TODO"),
        i(0, "pass"),
    }),

    snippet(";def", "Function Definition", [[
        def <name>(<self><args>)<ret>:
            <body>
    ]], {
        name = i(1, "function"),
        self = self(2),
        args = i(2),
        ret  = c(3, {
            t "",
            sn(nil, { t " -> ", i(1, "None") }),
        }),
        body = c(4, {
            i(1, "raise NotImplementedError()"),
            i(1, "pass"),
        }),
    }),

    snippet(";cl", "Class", [[
        class <name>:
            <body>
    ]], {
        name = i(1, "Name"),
        body = i(0, "pass"),
    }),


    snippet(";init", "Constructor", [[
        def __init__(self<comma><args>) ->> None:
        <assigns>
            <body>
    ]], {
        comma   = if_empty(1, "", ", "),
        args    = i(1),
        assigns = assign_list(2, { from = 1 }),
        body    = i(3, "pass"),
    }),

    snippet(";f", "For Loop", [[
        for <var> in <iter>:
            <body>
    ]], {
        var = i(1, "i"),
        iter = c(2, {
            i(1, "iterable"),
            fmta("range(<>)", {
                i(1, "10"),
            })
        }),
        body = i(0, "pass"),
    }),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
