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
-- FUNCTIONS & HELPERS
--------------------------------------------------------------------------------

local function cmake_scope(index)
    return c(index, {
        t "PRIVATE",
        t "PUBLIC",
        t "INTERFACE",
    })
end

local function cmake_lib_type(index)
    return c(index, {
        t "STATIC",
        t "SHARED",
        t "INTERFACE",
    })
end

local function cmake_switch(index)
    return c(index, {
        t "OFF",
        t "ON"
    })
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet(";min", "CMake minimum version", [[
        cmake_minimum_required(VERSION <>)
    ]], {
        i(1, "3.22"),
    }),

    snippet(";proj", "CMake project", [[
        project(
            <name>
            VERSION     <version>
            LANGUAGES   <langs>
        )
    ]], {
        name = i(1, "projectname"),
        version = i(2, "0.0.1"),
        langs = i(3, "CXX"),
    }),

    snippet(";inc", "Include", [[
        include(<>)
    ]], {
        i(1, "module"),
    }),

    snippet(";find", "Find package", [[
        find_package(<>)
    ]], {
        i(1, "package"),
    }),

    snippet(";opt", "Option", [[
        option(<name> <desc> <default>)
    ]], {
        name = i(1, "OPTION_NAME"),
        desc = i(2, "\"Description\""),
        default = cmake_switch(3),
    }),

    snippet(";dir", "Add subdirectory", [[
        add_subdirectory(<>)
    ]], {
        i(1, "directory"),
    }),

    snippet(";exec", "Add executable", [[
        add_executable(
            <target>
                <files>
        )
    ]], {
        target = i(1, "target"),
        files = i(2, "files"),
    }),

    snippet(";lib", "Add library", [[
        add_library(
            <target>
            <type>
                <files>
        )
    ]], {
        target = i(1, "target"),
        type = cmake_lib_type(2),
        files = i(3, "files"),
    }),

    snippet(";tll", "Target link libraries", [[
        target_link_libraries(
            <target>
            <scope>
                <library>
        )
    ]], {
        target = i(1, "target"),
        scope = cmake_scope(2),
        library = i(3, "library")
    }),

    snippet(";tid", "Target include directories", [[
        target_include_directories(
            <target>
            <scope>
                <library>
        )
    ]], {
        target = i(1, "target"),
        scope = cmake_scope(2),
        library = i(3, "${CMAKE_SOURCE_DIR}/include")
    }),

    snippet(";tcd", "Target compile definitions", [[
        target_compile_definitions(
            <target>
            <scope>
                <definitions>
        )
    ]], {
        target = i(1, "target"),
        scope = cmake_scope(2),
        definitions = i(3, "${CMAKE_SOURCE_DIR}/DEFINITION")
    }),
}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
