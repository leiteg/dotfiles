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
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node
local r = ls.restore_node

-- Luasnip Extras
local fmta = require("luasnip.extras.fmt").fmta

--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

function _()
    return nil
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet(";main", "Main Function", [[
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

    -- TYPES -------------------------------------------------------------------

    snippet(";o", "Option", "Option<<<t>>>", {
        t = i(0, "()"),
    }),

    snippet(";r", "Result", "Result<<<t>, <e>>>", {
        t = i(1, "()"),
        e = i(0, "Error"),
    }),

    snippet(";v", "Vec", "Vec<<<t>>>", {
        t = i(0, "()"),
    }),

    snippet(";s", "String", "String", {}),

    snippet(";h", "HashMap", "HashMap<<<key>, <value>>>", {
        key = i(1, "Key"),
        value = i(0, "Value"),
    }),

    -- MACROS ------------------------------------------------------------------

    snippet(";p", "println!", "println!(\"<str>\");", {
        str = i(1, "{}"),
    }),

    snippet(";pe", "eprintln!", "eprintln!(\"<str>\");", {
        str = i(1, "{}"),
    }),

    snippet(";a", "assert!", "assert!(<cond>);", {
        cond = i(1, "true"),
    }),

    snippet(";a=", "assert_eq!", "assert_eq!(<a>, <b>);", {
        a = i(1, "true"),
        b = i(2, "true"),
    }),

    snippet(";a!", "assert_ne!", "assert_ne!(<a>, <b>);", {
        a = i(1, "true"),
        b = i(2, "false"),
    }),

    snippet(";dd", "Derive Macro", "#[derive(<trait>)]", {
        trait = i(1, "Debug")
    }),

    -- ITEMS -------------------------------------------------------------------

    snippet(";fn", "Function", [[
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

    snippet(";st", "Struct", [[
        struct <name> {
            <fields>
        }
    ]], {
        name = i(1, "Name"),
        fields = i(2)
    }),

    snippet(";en", "Enum", [[
        enum <name> {
            <variants>
        }
    ]], {
        name = i(1, "Name"),
        variants = i(2)
    }),

    snippet(";imp", "Impl Block", [[
        impl <kinds> {
            <body>
        }
    ]], {
        -- TODO: Support generic impl blocks
        kinds = c(1, {
            fmta("<>", { r(1, "type") }),
            fmta("<> for <>", { i(1, "Trait"), r(2, "type") }),
        }),
        body = i(2, "todo!();"),
    }, {
        stored = { ["type"] = i(1, "Type") },
    }),

    snippet(";tr", "Trait", [[
        trait <name> {
            <body>
        }
    ]], {
        name = i(1, "Name"),
        body = i(2, "todo!();"),
    }),

    -- STATEMENTS --------------------------------------------------------------

    snippet(";match", "Match Statement", [[
        match <name> {
            <body>
        }
    ]], {
        name = i(1),
        body = i(2),
    }),

    snippet(";case", "Case", [[
        <lhs> =>> <rhs>,
    ]], {
        lhs = i(1, "lhs"),
        rhs = i(2, "rhs"),
    }),

    snippet(";r", "Return", "return <>;", {
        i(1, "None");
    }),

    -- TESTING -----------------------------------------------------------------

    snippet(";modtest", "Test Module", [[
        #[cfg(test)]
        mod test {
            use super::*;

            <body>
        }
    ]], {
        body = i(1),
    }),

    snippet(";test", "Test Case", [[
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
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
