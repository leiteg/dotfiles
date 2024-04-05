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
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt

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

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {

    snippet("def", "Function Definition", [[
        def <name>(<args>)<ret>:
            <body>
    ]], {
        name = i(1, "function"),
        args = c(2, {
            t "",
            fmt("{}", { i(1, "args") }),
            fmt("self, {}", { i(1, "args") }),
        }),
        ret  = c(3, {
            t "",
            sn(nil, { t " -> ", i(1, "None") }),
        }),
        body = c(4, {
            t "raise NotImplementedError()",
            t "pass",
        }),
    }),

    snippet("class", "Class", [[
        class <name>:
            <body>
    ]], {
        name = i(1, "Name"),
        body = i(0, "pass"),
    }),


    snippet("init", "Constructor", [[
        def __init__(self<comma><args>) ->> None:
        <assigns>
            <body>
    ]], {
        comma   = if_empty(1, "", ", "),
        args    = i(1),
        assigns = assign_list(2, { from = 1 }),
        body    = i(3, "pass"),
    }),


    snippet("p", "Print", "print(<msg>)", {
        msg = i(1, "message"),
    }),

    snippet("log", "Info", "log.info(<msg>)", {
        msg = i(1, "message"),
    }),

    snippet("debug", "Debug", "log.debug(<msg>)", {
        msg = i(1, "message"),
    }),

    snippet("info", "Info", "log.info(<msg>)", {
        msg = i(1, "message"),
    }),

    snippet("warn", "Warn", "log.warning(<msg>)", {
        msg = i(1, "message"),
    }),

    snippet("error", "Error", "log.error(<msg>)", {
        msg = i(1, "message"),
    }),

}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet("#!", "Shebang", [[
        #!/usr/bin/env python3

        <s>
    ]], { s = i(0) }),

    snippet("!impl", "Not Implemented", "raise NotImplementedError()", {}),

    snippet("!exit", "Exit", "raise SystemExit(<code>)", {
        code = i(1, "0"),
    }),

    snippet("!main", "Entry point", [[
        if __name__ == "__main__":
            <body>
    ]], {
        body = i(1, "pass"),
    }),

    snippet("!h1", "Header 1", [[
        # ==============================================================================
        # <text>
        # ==============================================================================
    ]], {
        text = i(1, "Header"),
    }),

    snippet("!h2", "Header 2", [[
        # ------------------------------------------------------------------------------
        # <text>
        # ------------------------------------------------------------------------------
    ]], {
        text = i(1, "Header"),
    }),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
