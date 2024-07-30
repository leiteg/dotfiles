--------------------------------------------------------------------------------
-- REQUIRES
--------------------------------------------------------------------------------

-- @see: https://github.com/ejmastnak/dotfiles/blob/main/config/nvim/LuaSnip/tex

local ls = require("luasnip")
local utils = require("core.lib.sniputils")

--------------------------------------------------------------------------------
-- INITIALIZATIONS
--------------------------------------------------------------------------------

-- Utils
local snippet = utils.snippet
local regex_snippet = utils.regex_snippet
local inline_snippet = utils.inline_snippet

-- Luasnip
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

-- Luasnip Extras
local extras = require("luasnip.extras")
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta

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

local function math(trig, desc, pat, nodes, opts)
    if nodes == nil then
        nodes = {}
    end

    if opts == nil then
        opts = {}
    end

    return snippet(trig, desc, pat, nodes, vim.tbl_deep_extend("force", {
        condition = in_mathzone,
        wordTrig = false,
    }, opts))
end

local function wmath(trig, desc, pat, nodes, opts)
    if opts == nil then
        opts = {}
    end
    return math(trig, desc, pat, nodes, vim.tbl_deep_extend("force", { wordTrig = true}, opts))
end

local function regex_math(trig, desc, pat, nodes, opts)
    if nodes == nil then
        nodes = {}
    end

    if opts == nil then
        opts = {}
    end

    return snippet(trig, desc, pat, nodes, vim.tbl_deep_extend("keep", {
        condition = in_mathzone,
        regTrig = true,
        wordTrig = false,
    }, opts))
end

local function greek(trig, text)
    return math(trig, "Greek letter " .. text, text, {}, {})
end

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------

local snippets = {

    snippet("@", "Cite", "~\\cite{<>}", { i(1) }),
    snippet("b", "Bold", "\\textbf{<>}", { i(1) }),
    snippet("i", "Italic", "\\textit{<>}", { i(1) }),
    snippet("t", "Monospaced", "\\texttt{<>}", { i(1) }),

    snippet("###", "Subsubsection", "\\subsubsection{<>}", { i(1) }),
    snippet("##", "Subsection", "\\subsection{<>}", { i(1) }),
    snippet("#", "Section", "\\section{<>}", { i(1) }),

    regex_snippet("$(%a)", "Inline Math", [[$<f>$ ]], {
        f = utils.capture(1),
    }),

}

--------------------------------------------------------------------------------
-- AUTOSNIPPETS
--------------------------------------------------------------------------------

local autosnippets = {

    snippet(";use", "Use Package", "\\usepackage{<pack>}", {
        pack = i(1, "package"),
    }),

    -- ENVIRONMENTS ------------------------------------------------------------

    snippet(";env", "Environment", [[
        \begin{<open>}
            <body>
        \end{<close>}
    ]], {
        open = i(1, "environment"),
        body = i(2, "%"),
        close = rep(1),
    }),

    snippet(";ul", "Itemize", [[
        \begin{itemize}
            <body>
        \end{itemize}
    ]], { body = i(1, "%"), }),

    snippet(";ol", "Enumerate", [[
        \begin{enumerate}
            <body>
        \end{enumerate}
    ]], { body = i(1, "%"), }),

    snippet("^(%s+)-", "Item", [[
        <space>\item <text>
    ]], {
        space = utils.capture(1),
        text = i(0),
    }, {
        condition = in_list,
        regTrig = true,
    }),

    snippet(";fig", "Figure", [[
        \begin{figure}[ht]
          \centering
          \includegraphics[width=<width>\textwidth]{images/<image>}
          \caption{<caption>}
          \label{fig:<label>}
        \end{figure}
    ]], {
        width = i(1, "0.75"),
        image = i(2, "image.png"),
        caption = i(3, "TODO"),
        label = i(4, "label"),
    }),

    snippet(";sfig", "Side Figure", [[
        \begin{figure}[ht]
            \centering
            \begin{subfigure}{.5\textwidth}
                \centering
                \includegraphics[width=0.95\linewidth]{images/<image1>}
                \caption{<subcaption1>}
                \label{fig:<sublabel1>}
            \end{subfigure}%
            \begin{subfigure}{.5\textwidth}
                \centering
                \includegraphics[width=0.95\linewidth]{images/<image2>}
                \caption{<subcaption2>}
                \label{fig:<sublabel2>}
            \end{subfigure}
            \caption{<caption>}
            \label{fig:<label>}
        \end{figure}
    ]], {
        image1 = i(1, "image.png"),
        subcaption1 = i(2, "TODO"),
        sublabel1 = i(3, "label"),
        image2 = i(4, "image.png"),
        subcaption2 = i(5, "TODO"),
        sublabel2 = i(6, "label"),
        caption = i(7, "TODO"),
        label = i(8, "label"),
    }),

    snippet(";alg", "Algorithm", [[
        \begin{algorithm}
          \KwData{<data>}
          \KwReturn{<ret>}

          \caption{<caption>}
          \label{alg:<label>}
        \end{algorithm}
    ]], {
        data = i(1, "Input data"),
        ret = i(2, "Return data"),
        caption = i(3, "\\TODO"),
        label = i(4, "label"),
    }),

    snippet(";tab", "Table", [[
        \begin{table}[ht]
          \centering
          \caption{<caption>}
          \label{tab:<label>}
          \begin{tabular}{<cols>}
            \toprule
            a & b \\
            \midrule
            c & d \\
            e & f \\
            \bottomrule
          \end{tabular}
        \end{table}
    ]], {
        caption = i(1, "caption"),
        label = i(2, "label"),
        cols = i(3, "cc"),
    }),

    -- TODO: Listing

    snippet(";eq", "Equation", [[
        \begin{equation}
          <body>
        \end{equation}
    ]], { body = i(1, "%"), }),

    snippet(";ali", "Align", [[
        \begin{align<ast1>}
          <body>
        \end{align<ast2>}
    ]], {
        body = i(2, "%"),
        ast1 = c(1, { t "", t "*" }),
        ast2 = rep(1),
    }),

    snippet(";th", "Theorem", [[
        \begin{theorem}
          <body>
        \end{theorem}
    ]], { body = i(1, "%"), }),

    snippet(";pr", "Proof", [[
        \begin{proof}
          <body>
        \end{proof}
    ]], { body = i(1, "%"), }),

    snippet(";abs", "Abstract", [[
        \begin{abstract}
          <body>
        \end{abstract}
    ]], { body = i(1, "%"), }),

    -- MATH SNIPPETS -----------------------------------------------------------

    math("sum", "Summation", "<>", {
        c(1, {
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

    math("br", "Brackets", "<>", {
        c(1, {
            fmta("\\left( <eq> \\right)", { eq = i(1, "x") }),
            fmta("\\left[ <eq> \\right]", { eq = i(1, "x") }),
            fmta("\\left\\{ <eq> \\right\\}", { eq = i(1, "x") }),
            fmta("\\left\\| <eq> \\right\\|", { eq = i(1, "x") }),
        }),
    }),

    math("mod", "Modulus", [[\|<eq>\|]], {
        eq = i(1, "x"),
    }),

    math("//", "Fraction", [[\frac{<a>}{<b>}]], {
        a = i(1, "a"),
        b = i(2, "b"),
    }),

    wmath("==", "Equals", [[&= ]]),
    wmath("!=", "Not Equals", [[\ne ]]),
    wmath(">=", "Greater Than Or Equals", [[\ge ]]),
    wmath("<=", "Less Than Or Equals", [[\le ]]),
    wmath("=>", "Implies", [[\implies ]]),
    wmath("->", "To", [[\to ]]),
    wmath("!>", "Maps To", [[\mapsto ]]),
    wmath("nin", "Not In", [[\notin ]]),
    wmath("in", "In", [[\in ]]),
    wmath("xx", "Times", [[\times ]]),
    wmath("..", "Dot", [[\cdot ]]),
    wmath("cc", "Subset", [[\subset ]]),
    wmath("c=", "Subset Equal", [[\subseteq ]]),
    wmath("NN", "Natural Set", [[\mathbb{N} ]]),
    wmath("ZZ", "Integer Set", [[\mathbb{Z} ]]),
    wmath("RR", "Real Set", [[\mathbb{R} ]]),
    wmath("iff", "iff Set", [[\iff ]]),
    wmath("nabla", "Nabla", [[\nabla ]]),
    wmath("grad", "Nabla", [[\nabla ]]),
    wmath("part", "Partial", [[\partial ]]),

    greek(";a", "\\alpha"),
    greek(";b", "\\beta"),
    greek(";g", "\\gamma"),
    greek(";G", "\\Gamma"),
    greek(";d", "\\delta"),
    greek(";D", "\\Delta"),
    greek(";e", "\\epsilon"),
    greek(";ve", "\\varepsilon"),
    greek(";z", "\\zeta"),
    greek(";h", "\\eta"),
    greek(";t", "\\theta"),
    greek(";vt", "\\vartheta"),
    greek(";t", "\\Theta"),
    greek(";i", "\\iota"),
    greek(";k", "\\kappa"),
    greek(";l", "\\lambda"),
    greek(";L", "\\Lambda"),
    greek(";m", "\\mu"),
    greek(";n", "\\nu"),
    greek(";x", "\\xi"),
    greek(";X", "\\Xi"),
    greek(";p", "\\pi"),
    greek(";P", "\\Pi"),
    greek(";r", "\\rho"),
    greek(";vr", "\\varrho"),
    greek(";s", "\\sigma"),
    greek(";S", "\\Sigma"),
    greek(";o", "\\tau"),
    greek(";u", "\\upsilon"),
    greek(";U", "\\Upsilon"),
    greek(";f", "\\phi"),
    greek(";vf", "\\varphi"),
    greek(";F", "\\Phi"),
    greek(";c", "\\chi"),
    greek(";j", "\\psi"),
    greek(";J", "\\Psi"),
    greek(";w", "\\omega"),
    greek(";W", "\\Omega"),

    regex_math("([%w%)%]%}|]):", "Superscript", [[<a>^{<b>}]], {
        a = utils.capture(1),
        b = i(1),
    }),

    regex_math("([%w%)%]%}|]);", "Subscript", [[<a>_{<b>}]], {
        a = utils.capture(1),
        b = i(1),
    }),

    regex_math("([%w%)%]%}|])__", "Sub and superscript", [[<a>^{<b>}_{<c>}]], {
        a = utils.capture(1),
        b = i(1),
        c = i(2),
    }),

    regex_math("([^%a])vv", "Vector", [[<a>\vec{<b>}]], {
        a = utils.capture(1),
        b = i(1),
    }),

    regex_math("([^%a])hh", "Hat", [[<a>\hat{<b>}]], {
        a = utils.capture(1),
        b = i(1),
    }),

    regex_math("([^%a])dd", "Dot", [[<a>\dot{<b>}]], {
        a = utils.capture(1),
        b = i(1),
    }),

    regex_math("([^%a])bb", "Bar", [[<a>\bar{<b>}]], {
        a = utils.capture(1),
        b = i(1),
    }),

    regex_math("([^%a])sq", "Square Root", [[<a>\sqrt{<b>}]], {
        a = utils.capture(1),
        b = i(1),
    }),

}

--------------------------------------------------------------------------------
-- RETURN
--------------------------------------------------------------------------------

return snippets, autosnippets
