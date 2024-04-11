--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("core.lib.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------

local snippet = utils.snippet
local i = ls.i
local t = ls.t
local d = ls.dynamic_node
local sn = ls.snippet_node

--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

local function last_in_path(index, opts)
    local function _(args)
        local last = ""
        for arg in string.gmatch(args[1][1], '([^.]+)') do
            last = arg
        end
        last = last:gsub("-", "_")
        return sn(nil, t(last))
    end
    return d(index, _, { opts.from })
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet(";req", "Require", [[
        local <name> = require("<pack>")
    ]], {
        pack = i(1),
        name = last_in_path(2, { from = 1 }),
    }),

    snippet(";fn", "Function", [[
        function(<args>)
            <body>
        end
    ]], {
        args = i(1),
        body = i(0, "return nil"),
    }),

    snippet(";lfn", "Local Function", [[
        local function <name>(<args>)
            <body>
        end
    ]], {
        name = i(1, "name"),
        args = i(2),
        body = i(0, "return nil"),
    }),

    snippet(";ins", "Table Insert", [[
        table.insert(<table>, <value>)
    ]], {
        table = i(1, "table"),
        value = i(2, "value"),
    }),

    snippet(";p", "Print", [[print(<>)]], {
        i(1, "message")
    }),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------
return snippets, autosnippets
