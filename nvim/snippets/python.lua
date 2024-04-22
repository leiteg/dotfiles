--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("core.lib.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATIONS
--------------------------------------------------------------------------------

-- Utils
local snippet = utils.snippet
local treesitter = utils.treesitter_snippet_factory("python")

-- Luasnip
local i = ls.i
local c = ls.c
local t = ls.t
local f = ls.f
local d = ls.dynamic_node
local r = ls.restore_node
local sn = ls.snippet_node

-- Luasnip Extras
local l = require("luasnip.extras").lambda
local fmta = require("luasnip.extras.fmt").fmta

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

local function self(from)
    local _ = function(args)
        if utils.ts_is_inside("class_definition") then
            if args[1][1] ~= "" then
                return "self, "
            end
            return "self"
        end
        return ""
    end

    return f(_, { from }, {})
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {

    treesitter("@iter", [[
        [
            (attribute)
            (identifier)
            (call)
        ] @prefix
    ]], "<>", {
        c(1, {
            fmta([[
                for <item> in <var>:
                    <body>
            ]], {
                item = r(1, "item"),
                var = l(l.LS_TSMATCH),
                body = r(2, "body"),
            }),
            fmta([[
                for <idx>, <item> in enumerate(<var>):
                    <body>
            ]], {
                idx = i(3, "i"),
                item = r(1, "item"),
                var = l(l.LS_TSMATCH),
                body = r(2, "body"),
            }),
        })
    }, {
        stored = {
            ["item"] = i(1, "item"),
            ["body"] = i(2, "pass"),
        },
    }),

    treesitter("@trig", [[
        (class_definition
            name: (identifier)) @prefix
    ]], [[
        @dataclass
        <>
    ]], { l(l.LS_TSMATCH) }),

}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet("#!", "Shebang", [[
        #!/usr/bin/env python3

        <>
    ]], { i(0) }),

    snippet(";impl", "Not Implemented", "raise NotImplementedError()", {}),

    snippet(";q", "Exit", "raise SystemExit(<>)", { i(1, "0"), }),

    snippet(";main", "Entry point", [[
        if __name__ == "__main__":
            <>
    ]], { i(1, "pass"), }),

    snippet(";h1", "Header 1", [[
        # ==============================================================================
        # <>
        # ==============================================================================
        <>
    ]], { i(1, "Header"), i(0) }),

    snippet(";h2", "Header 2", [[
        # ------------------------------------------------------------------------------
        # <>
        # ------------------------------------------------------------------------------
        <>
    ]], { i(1, "Header"), i(0) }),

    snippet(";todo", "TODO Comment", [[
        # TODO: <>
    ]], { i(1, "...") }),

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
    ]], { i(1, "TODO"), i(0), }),

    snippet(";fn", "Function Definition", [[
        def <name>(<self><args>)<ret>:
            <body>
    ]], {
        name = i(1, "function"),
        self = self(2),
        args = i(2),
        ret  = c(3, {
            sn(nil, { t " -> ", i(1, "None") }),
            t "",
        }),
        body = i(4, "pass"),
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
        comma   = utils.if_empty(1, "", ", "),
        args    = i(1),
        assigns = assign_list(2, { from = 1 }),
        body    = i(3, "pass"),
    }),

    snippet(";for", "For Loop", [[
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
