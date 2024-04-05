--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("config.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATIONS
--------------------------------------------------------------------------------

local snippet = utils.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

--[[
local s = ls.snippet
local isn = ls.indent_snippet_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
--]]

--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

function _()
    return nil
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {

    -- MACROS ------------------------------------------------------------------

    snippet("p", "Stdout Print", "println!(\"<str>\");", {
        str = i(1, "{}"),
    }),

    snippet("pe", "Stderr Print", "eprintln!(\"<str>\");", {
        str = i(1, "{}"),
    }),

    snippet("a", "Assert", "assert!(<cond>);", {
        cond = i(1, "true"),
    }),

    snippet("a=", "Assert Equal", "assert_eq!(<a>, <b>);", {
        a = i(1, "true"),
        b = i(2, "true"),
    }),

    snippet("a!", "Assert Not Equal", "assert_ne!(<a>, <b>);", {
        a = i(1, "true"),
        b = i(2, "false"),
    }),

    -- TYPES -------------------------------------------------------------------

    snippet("o", "Option", "Option<<<t>>>", {
        t = i(0, "()"),
    }),

    snippet("r", "Result", "Result<<<t>, <e>>>", {
        t = i(1, "()"),
        e = i(0, "Error"),
    }),

    snippet("v", "Vec", "Vec<<<t>>>", {
        t = i(0, "()"),
    }),

    snippet("m", "HashMap", "HashMap<<<key>, <value>>>", {
        key = i(1, "Key"),
        value = i(0, "Value"),
    }),

    -- ITEMS -------------------------------------------------------------------

    snippet("fn", "Function", [[
        fn <name>(<args>)<ret> {
            <body>
        }
    ]], {
        name = i(1, "name"),
        args = i(2),
        ret = c(3, {
            t "",
            sn(nil, { t " -> ", i(1, "()") })
        }),
        body = i(0, "todo!()"),
    }),

    snippet("struct", "Struct", [[
        struct <name> {
            <fields>
        }
    ]], {
        name = i(1, "Name"),
        fields = i(2)
    }),

    -- TODO: Enum
    -- TODO: Trait
    -- TODO: Impl

    -- TESTING -----------------------------------------------------------------

    snippet("modtest", "Test Module", [[
        #[cfg(test)]
        mod test {
            use super::*;

            <body>
        }
    ]], {
        body = i(1),
    }),

    snippet("test", "Test Case", [[
        #[test]
        fn <name>() {
            <body>
        }
    ]], {
        name = i(1, "name"),
        body = i(2, "assert!(true);"),
    }),

}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet("!main", "Main Function", [[
        fn main()<type> {
            <body>
            <ret>
        }
    ]], {
        type = c(1, {
            t "",
            sn(nil, { t " -> Result<(), ", i(1, "Error"), t ">" })
        }),
        body = i(0, "println!(\"Hello, World\");"),
        ret = utils.if_empty(1, "", "Ok(())"),
    }),

    snippet("!d", "Derive Macro", "#[derive(<trait>)]", {
        trait = i(1, "Debug")
    }),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
