--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

local ls = require("luasnip")
local utils = require("config.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATIONS
--------------------------------------------------------------------------------

local snippet = utils.snippet
local regex_snippet = utils.regex_snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local extras = require("luasnip.extras")
local rep = extras.rep
local conds = require("luasnip.extras.expand_conditions")
local fmta = require("luasnip.extras.fmt").fmta
local f = ls.function_node

--[[
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local d = ls.dynamic_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local l = extras.lambda
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
--]]

--------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------

local function in_mathzone()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function in_list()
    local ul = vim.fn["vimtex#env#is_inside"]("itemize")
    local ol = vim.fn["vimtex#env#is_inside"]("enumerate")
    return (ul[1] > 0 and ul[2] > 0) or (ol[1] > 0 and ol[2] > 0)
end

local function math_snippet(trig, desc, pat, nodes, opts)
    if opts == nil then
        opts = {}
    end

    return snippet(trig, desc, pat, nodes, vim.tbl_deep_extend("keep", {
        condition = in_mathzone,
        wordTrig = false,
    }, opts))
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {

    snippet("@", "Cite", "~\\cite{<text>}", { text = i(1) }),
    snippet("b", "Bold", "\\textbf{<text>}", { text = i(1) }),
    snippet("i", "Italic", "\\textit{<text>}", { text = i(1) }),
    snippet("t", "Monospaced", "\\texttt{<text>}", { text = i(1) }),

    snippet("###", "Subsubsection", "\\subsubsection{<text>}", { text = i(1) }),
    snippet("##", "Subsection", "\\subsection{<text>}", { text = i(1) }),
    snippet("#", "Section", "\\section{<text>}", { text = i(1) }),

    regex_snippet("$(%a)", "Inline Math", [[$<f>$ ]], {
        f = utils.capture(1),
    }),

}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet("!use", "Use Package", "\\usepackage{<pack>}", {
        pack = i(1, "package"),
    }),

    snippet("!env", "Environment", [[
        \begin{<open>}
            <body>
        \end{<close>}
    ]], {
        open = i(1, "environment"),
        body = i(0, "%"),
        close = rep(1),
    }),

    snippet("!ul", "Itemize", [[
        \begin{itemize}
            <body>
        \end{itemize}
    ]], { body = i(0, "%"), }),

    snippet("!ol", "Enumerate", [[
        \begin{enumerate}
            <body>
        \end{enumerate}
    ]], { body = i(0, "%"), }),

    snippet("-", "Item", [[
        \item <text>
    ]], {
        text = i(0),
    }, {
        condition = in_list,
    }),

    snippet("!fig", "Figure", [[
        \begin{figure}[ht]
            \centering
            \includegraphics[width=<width>\textwidth]{images/<image>}
            \caption{<caption>}
            \label{fig:<label>}
        \end{figure}
    ]], {
        width = i(1, "0.75"),
        image = i(2, "image.png"),
        caption = i(3, "Caption"),
        label = i(4, "label"),
    }),

    -- TODO: Side-by-side Figure
    -- TODO: Table
    -- TODO: Listing

    snippet("!eq", "Equation", [[
        \begin{equation}
            <body>
        \end{equation}
    ]], { body = i(0, "%"), }),

    snippet("!al", "Align", [[
        \begin{align*}
            <body>
        \end{align*}
    ]], { body = i(0, "%"), }),

    snippet("!th", "Theorem", [[
        \begin{theorem}
            <body>
        \end{theorem}
    ]], { body = i(0, "%"), }),

    snippet("!pr", "Proof", [[
        \begin{proof}
            <body>
        \end{proof}
    ]], { body = i(0, "%"), }),

    snippet("!abs", "Abstract", [[
        \begin{abstract}
            <body>
        \end{abstract}
    ]], { body = i(0, "%"), }),

    math_snippet("sum", "Summation", "<s>", {
        s = c(1, {
            fmta([[\sum_{<a>}^{<b>} ]], {
                a = i(1, "i = 0"),
                b = i(2, "n"),
            }),
            fmta([[\sum_{<a>} ]], {
                a = i(1, "i \\in \\mathbb{R}"),
            }),
            t "\\sum ",
        })
    }),

    math_snippet("br", "Brackets", "<s>", {
        s = c(1, {
            fmta("\\left( <eq> \\right)", { eq = i(1, "x") }),
            fmta("\\left[ <eq> \\right]", { eq = i(1, "x") }),
            fmta("\\left\\{ <eq> \\right\\}", { eq = i(1, "x") }),
            fmta("\\left\\| <eq> \\right\\|", { eq = i(1, "x") }),
        }),
    }),

    math_snippet("mod", "Modulus", [[\|<eq>\|]], {
        eq = i(0, "x"),
    }),

    math_snippet("//", "Fraction", [[\frac{<a>}{<b>}]], {
        a = i(1, "a"),
        b = i(2, "b"),
    }),

    math_snippet("==", "Equals", [[&= ]], {}),
    math_snippet("!=", "Not Equals", [[\neq ]], {}),
    math_snippet(">=", "Greater Than Or Equals", [[\geq ]], {}),
    math_snippet("<=", "Less Than Or Equals", [[\leq ]], {}),
    math_snippet("=>", "Implies", [[\implies ]], {}),
    math_snippet("->", "To", [[\to ]], {}),
    math_snippet("!>", "Maps To", [[\mapsto ]], {}),
    math_snippet("nin", "Not In", [[\notin ]], {}),
    math_snippet("in", "In", [[\in ]], {}),
    math_snippet("xx", "Times", [[\times ]], {}),
    math_snippet("**", "Dot", [[\cdot ]], {}),
    math_snippet("cc", "Subset", [[\subset ]], {}),
    math_snippet("c=", "Subset Equal", [[\subseteq ]], {}),
    math_snippet("NN", "Natural Set", [[\mathbb{N} ]], {}),
    math_snippet("ZZ", "Integer Set", [[\mathbb{Z} ]], {}),
    math_snippet("RR", "Real Set", [[\mathbb{R} ]], {}),
    math_snippet("iff", "iff Set", [[\iff ]], {}),
    math_snippet("nabla", "Nabla", [[\nabla ]], {}),
    math_snippet("part", "Partial", [[\partial ]], {}),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
