--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("config.sniputils")

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
        return sn(nil, t(last))
    end
    return d(index, _, { opts.from })
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {

    snippet("req", "Require", [[
        local <name> = require("<pack>")
    ]], {
        pack = i(1),
        name = last_in_path(2, { from = 1 }),
    }),

    snippet("fn", "Function", [[
        local function <name>(<args>)
            <body>
        end
    ]], {
        name = i(1, "name"),
        args = i(2),
        body = i(0, "return nil"),
    }),

}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
