--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("core.lib.sniputils")
local ts_utils = require("nvim-treesitter.ts_utils")

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

local query_rvalue = [[
    [
        (call)
        (identifier)
        (attribute)
    ] @prefix
]]

local query_identifier = [[
    (identifier) @prefix
]]

local query_class = [[
    (class_definition
        name: (identifier)) @prefix
]]

--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

local function assign_list(index, opts)
    local function generate(args)
        local result = {}

        if args[1][1] == "" or args[1][1] == nil then
            return sn(nil, t({ "    pass" }))
        end

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

local function docstring_arg_nodes(parameters)
    if #parameters == 0 then
        return nil
    end

    if parameters[1]:child_count() <= 2 then
        return nil
    end

    local nodes = {
        t { "", "Args:", "" }
    }

    local idx = 1

    for param in parameters[1]:iter_children() do
        local id = nil
        local type = nil

        if param:type() == "identifier" then
            id = utils.ts_node_text(param)
            table.insert(nodes, t(string.format("    %s: ", id)))
            table.insert(nodes, i(idx, "..."))
            table.insert(nodes, t { "", "" })
            idx = idx + 1
        end

        if param:type() == "typed_parameter" then
            id = utils.ts_node_text(param:child(0))
            type = utils.ts_node_text(param:child(2))
            table.insert(nodes, t(string.format("    %s (%s): ", id, type)))
            table.insert(nodes, i(idx, "..."))
            table.insert(nodes, t { "", "" })
            idx = idx + 1
        end

        if param:type() == "list_splat_pattern" or param:type() == "dictionary_splat_pattern" then
            id = utils.ts_node_text(param:child(1))
            table.insert(nodes, t(string.format("    %s: ", id)))
            table.insert(nodes, i(idx, "..."))
            table.insert(nodes, t { "", "" })
            idx = idx + 1
        end
    end

    return sn(2, nodes)
end

local function docstring_ret_nodes(return_type)
    if #return_type == 0 then
        return nil
    end

    local type = utils.ts_node_text(return_type[1])
    return sn(3, {
        t { "", "Returns:", "    " .. type .. ": " },
        i(1, "..."),
        t { "", "" }
    })
end

local function docstring(idx)
    local generate = function(_)
        local nodes = { i(1, "Lorem ipsum dolor sit amet.") }

        local fn = utils.ts_parent_of_type("function_definition")
        if not fn then
            return sn(nil, nodes)
        end

        table.insert(nodes, t { "", "" })

        local argnode = docstring_arg_nodes(fn:field("parameters"))
        if argnode then
            table.insert(nodes, argnode)
        end

        local retnode = docstring_ret_nodes(fn:field("return_type"))
        if retnode then
            table.insert(nodes, retnode)
        end

        return sn(0, nodes)
    end

    return d(idx, generate, {})
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {

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
    snippet(";;", "Print", "print(<>)", { i(1, "message") }),
    snippet(";p", "Print", "print(<>)", { i(1, "message") }),
    snippet(";log", "Info", 'log.info(<>)', { i(1, "message") }),
    snippet(";deb", "Debug", 'log.debug(<>)', { i(1, "message") }),
    snippet(";info", "Info", 'log.info(<>)', { i(1, "message") }),
    snippet(";warn", "Warn", 'log.warning(<>)', { i(1, "message") }),
    snippet(";err", "Error", 'log.error(<>)', { i(1, "message") }),

    snippet(";doc", "Docstring", [[
        """<docstring>"""
    ]], {
        docstring = docstring(1),
    }),

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
    ]], {
        comma   = utils.if_empty(1, "", ", "),
        args    = i(1),
        assigns = assign_list(2, { from = 1 }),
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

    snippet(";r", "Return", "return <>", {
        i(1, "None"),
    }),

    snippet(";R", "Raise", "raise <>(<>)", {
        i(1, "Exception"),
        i(2),
    }),

    treesitter(";;", query_rvalue, [[
        for <item> in <var>:
            <body>
    ]], {
        item = i(1, "item"),
        var = l(l.LS_TSMATCH),
        body = i(2, "pass"),
    }),

    treesitter(";e", query_rvalue, [[
        for <idx>, <item> in enumerate(<var>):
            <body>
    ]], {
        idx = i(1, "i"),
        item = i(2, "item"),
        var = l(l.LS_TSMATCH),
        body = i(3, "pass"),
    }),

    treesitter(";z", query_rvalue, [[
        for <a>, <b> in zip(<lhs>, <rhs>):
            <body>
    ]], {
        rhs = i(1, "[]"),
        lhs = l(l.LS_TSMATCH),
        a = i(2, "a"),
        b = i(3, "b"),
        body = i(4, "pass"),
    }),

    treesitter(";c", query_identifier, [[
        class <name>:
            <body>
    ]], {
        name = l(l.LS_TSMATCH),
        body = i(1, "pass")
    }),

    treesitter(";d", query_class, [[
        @dataclass
        <>
    ]], { l(l.LS_TSMATCH) }),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
