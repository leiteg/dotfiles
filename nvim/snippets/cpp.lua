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
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node
local r = ls.restore_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- Luasnip Extras
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep

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

local function inherits(index, opts)
    local function _(class_name)
        -- Return inheritance snippet if class name ends with `:`.
        if class_name:match(":$") then
            return sn(nil, { t " public ", i(1, "Base") })
        end
        -- Otherwise, return empty snippet.
        return sn(nil, {})
    end

    return d(index, function(args) return _(args[1][1]) end, { opts.from })
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet("#!", "Include guard", [[
        #ifndef <>
        #define <>

        <>

        #endif /* <> */
    ]], { i(1, "FILE_H"), rep(1), i(0), rep(1) }),

    -- MAIN --------------------------------------------------------------------

    snippet(";main", "Main Function", [[
        int main(<args>) {
          <body>
          return 0;
        }
    ]], {
        args = c(1, {
            t "int argc, char **argv",
            t "void",
        }),
        body = i(0, 'printf("Hello, World!\\n");'),
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

    snippet(";t", "Template", "template <<class <>>>", {
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
        class <name><base> {
        public:
          <body>
        };
    ]], {
        name = i(1, "ClassName"),
        base = inherits(2, { from = 1 }),
        body = i(3, "// TODO"),
    }),

    snippet(";st", "Struct Declaration", [[
        struct <name><base> {
          <body>
        };
    ]], {
        name = i(1, "StructName"),
        base = inherits(2, { from = 1 }),
        body = i(3, "// TODO"),
    }),

    snippet(";en", "Enum Declaration", [[
        <enum> {
          <body>
        };
    ]], {
        enum = c(1, {
            fmt("enum {}", { r(1, "name") }),
            fmt("enum class {}", { r(1, "name") }),
        }),
        body = i(2, "// TODO"),
    }, {
        stored = { ["name"] = i(1, "EnumName") }
    }),

    snippet(";fn", "Function Declaration", [[
        <decl> {
          <body>
        }
    ]], {
        decl = c(1, {
            fmt("{} {}({})", { r(3, "rtyp"), r(1, "name"), r(2, "args") }),
            fmt("auto {}({}) -> {}", { r(1, "name"), r(2, "args"), r(3, "rtyp") }),
        }),
        body = i(2, "// TODO"),
    }, {
        stored = {
            rtyp = i(1, "void"),
            name = i(2, "function_name"),
            args = i(3),
        }
    }),

    -- STATEMENTS --------------------------------------------------------------

    snippet(";for", "For Loop", [[
        for (<iter>) {
          <body>
        }
    ]], {
        iter = c(1, {
            fmta("int <> = <>; <> << <>; ++<>", { r(1, "index"), i(2, "0"), rep(1), i(3, "n"), rep(1) }),
            fmta("auto &<> : <>", { r(1, "index"), r(2, "collection") }),
            fmta("const auto &<> : <>", { r(1, "index"), r(2, "collection") }),
        }),
        body = i(2, "// TODO"),
    }, {
        stored = {
            index = i(1, "i"),
            collection = i(2, "collection"),
        }
    }),

    snippet(";wh", "While Loop", "<>", {
        c(1, {
            fmta([[
                while (<>) {
                  <>
                }
            ]], { r(1, "cond"), r(2, "body") }),
            fmta([[
                do {
                  <>
                } while (<>);
            ]], { r(1, "body"), r(2, "cond") }),
        })
    }, {
        stored = {
            cond = i(1, "true"),
            body = i(2, "// TODO")
        }
    }),

    snippet(";r", "Return", "return <>;", {
        i(1, "nullptr");
    }),

    -- TYPES -------------------------------------------------------------------

    snippet(";U", "Unique Pointer", "std::unique_ptr<<<T>>>", {
        T = i(1, "T")
    }),

    snippet(";S", "Shared Pointer", "std::shared_ptr<<<T>>>", {
        T = i(1, "T")
    }),

    snippet(";mU", "Make Unique Pointer", "std::make_unique<<<T>>>(<V>)", {
        T = i(1, "T"),
        V = i(2),
    }),

    snippet(";mS", "Make Shared Pointer", "std::make_shared<<<T>>>(<V>)", {
        T = i(1, "T"),
        V = i(2),
    }),

    snippet(";V", "Vector", "std::vector<<<T>>>", {
        T = i(1, "T")
    }),

    snippet(";M", "Map", "std::map<<<K>, <V>>>", {
        K = i(1, "K"),
        V = i(2, "V"),
    }),

    snippet(";S", "String", "std::string", {}),

    -- PRINTING ----------------------------------------------------------------

    snippet(";;", "Print stdout", 'printf("<>\\n"<>);', {
        i(1, "Hello, World"),
        c(2, {
            t "",
            sn(nil, { t ", ", i(1, "args") })
        })
    }),

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
