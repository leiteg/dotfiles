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

-- Luasnip
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- Luasnip Extras
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep
local l = extras.lambda
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local k = require("luasnip.nodes.key_indexer").new_key
local ai = require("luasnip.nodes.absolute_indexer")
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local events = require("luasnip.util.events")

--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

local function lower(args)
    return args[1][1]:lower()
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet(";h1", "Header 1", [[
        //===----------------------------------------------------------------------===//
        // <>
        //===----------------------------------------------------------------------===//
    ]], { i(1, "Header") }),

    snippet(";dialect", "Dialect", [[
        def <name>_Dialect : Dialect {
            let name = "<lname>";
            let cppNamespace = "::mlir::<lname>";
            let summary = "<summary>";
            let description = [{<description>}];
        }
    ]], {
        name = i(1, "MyDialect"),
        lname = f(lower, {1}),
        summary = i(2),
        description = i(3),
    }),

    snippet(";op", "Op", [[
        def <op> : <baseop><<"<mnemonic>", [<traits>]>> {
            let summary = "";
            let description = [{}];
            let arguments = (ins);
            let results = (outs);
        }
    ]], {
        op = i(1, "MyOp"),
        baseop = i(2, "BaseOp"),
        mnemonic = f(lower, {1}),
        traits = i(3),
    }),
}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
