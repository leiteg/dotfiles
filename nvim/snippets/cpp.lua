--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("core.lib.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATIONS
--------------------------------------------------------------------------------

local snippet = utils.snippet

local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node
local r = ls.restore_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep

--[[
local s = ls.snippet
local isn = ls.indent_snippet_node
local d = ls.dynamic_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local l = extras.lambda
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

local function namespace_comment(args)
    local name = args[1][1]
    if name == "" then
        return "// Anonymous namespace"
    else
        return "// Namespace " .. name
    end
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    -- MAIN --------------------------------------------------------------------

    snippet(";main", "Main Function", [[
        int main(<args>) {
            <body>
            return 0;
        }
    ]], {
        args = c(1, {
            t "int argc, char **argv",
            t "",
        }),
        body = i(2, 'printf("Hello, World!\\n");'),
    }),

    -- DIRECTIVES --------------------------------------------------------------

    snippet(";inc", "Include", "<>", {
        c(1, {
            fmt("#include <{}>", { r(1, "lib"), }),
            fmt('#include "{}"', { r(1, "lib") }),
        })
    }, {
        stored = { ["lib"] = i(1, "iostream") },
    }),

    snippet(";omp", "Pragma Omp", "#pragma omp", {}),

    -- TEMPLATES ---------------------------------------------------------------

    snippet(";t", "Template", "template <<typename <>>>", {
        i(1, "T")
    }),

    -- DECLARATIONS ------------------------------------------------------------

    snippet(";ns", "Namespace", [[
        namespace <name><ws>{
        <body>
        } <comm>
    ]], {
        name = i(1, "name"),
        comm = f(namespace_comment, { 1 }),
        body = i(2, "// TODO"),
        ws = utils.if_empty(1, "", " "),
    }),

    snippet(";cl", "Class Declaration", [[
        class <name><inherits> {
        public:
            <body>
        };
    ]], {
        name = i(1, "ClassName"),
        inherits = c(2, {
            t "",
            sn(nil, { t " : public ", i(1, "BaseClass") }),
        }),
        body = i(3, "// TODO"),
    }),

    snippet(";st", "Struct Declaration", [[
        struct <name><inherits> {
            <body>
        };
    ]], {
        name = i(1, "StructName"),
        inherits = c(2, {
            t "",
            sn(nil, { t " : public ", i(1, "BaseClass") }),
        }),
        body = i(3, "// TODO"),
    }),

    snippet(";en", "Enum Declaration", [[
        enum<class> <name> {
            <body>
        };
    ]], {
        class = c(1, { t " class", t "" }),
        name = i(2, "EnumName"),
        body = i(3, "// TODO"),
    }),

    snippet(";fn", "Function Declaration", [[
        <ret> <name>(<args>) {
            <body>
        }
    ]], {
        ret = i(1, "void"),
        name = i(2, "function"),
        args = i(3),
        body = i(4, "// TODO"),
    }),

    -- STATEMENTS --------------------------------------------------------------

    snippet(";for", "For Loop", [[
        for (<iter>) {
            <body>
        }
    ]], {
        iter = c(1, {
            fmta("int <> = <>; <> << <>; ++<>", { i(1, "i"), i(2, "0"), rep(1), i(3, "n"), rep(1) }),
            fmta("auto &<> : <>", { i(1, "item"), i(2, "collection") }),
            fmta("const auto &<> : <>", { i(1, "item"), i(2, "collection") }),
        }),
        body = i(2, "// TODO"),
    }),

    -- TYPES -------------------------------------------------------------------

    snippet(";uu", "Unique Pointer", "std::unique_ptr<<<T>>>", {
        T = i(1, "T")
    }),

    snippet(";ss", "Shared Pointer", "std::shared_ptr<<<T>>>", {
        T = i(1, "T")
    }),

    snippet(";mu", "Make Unique Pointer", "std::make_unique<<<T>>>(<V>)", {
        T = i(1, "T"),
        V = i(2),
    }),

    snippet(";ms", "Make Shared Pointer", "std::make_shared<<<T>>>(<V>)", {
        T = i(1, "T"),
        V = i(2),
    }),

    snippet(";vec", "Vector", "std::vector<<<T>>>", {
        T = i(1, "T")
    }),

    snippet(";map", "Map", "std::map<<<K>, <V>>>", {
        K = i(1, "K"),
        V = i(2, "V"),
    }),

    snippet(";str", "String", "std::string", {}),

    -- PRINTING ----------------------------------------------------------------

    snippet(";p", "Print stdout", 'printf("<>\\n"<>);', {
        i(1, "Hello, World"),
        c(2, {
            t "",
            sn(nil, { t ", ", i(1, "args") })
        })
    }),

    snippet(";ep", "Print stderr", 'fprintf(stderr, "<>\\n"<>);', {
        i(1, "Hello, World"),
        c(2, {
            t "",
            sn(nil, { t ", ", i(1, "args") })
        })
    }),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
