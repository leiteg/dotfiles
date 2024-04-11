--[[
-- A modern Vim and neovim filetype plugin for LaTeX files.
--]]
return {
    "lervag/vimtex",
    ft = "tex",
    config = function()
        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_complete_close_braces = 1
        vim.g.vimtex_compiler_latexmk = {
            callback = 0,
            build_dir = 'build',
        }
        vim.g.vimtex_view_method = 'zathura'
        if vim.fn.has('mac') == 1 then
            vim.g.vimtex_view_method = 'skim'
        end
        vim.g.vimtex_syntax_conceal = {
            accents = 1,
            ligatures = 1,
            cites = 1,
            fancy = 1,
            greek = 1,
            math_bounds = 1,
            math_delimiters = 1,
            math_fracs = 1,
            math_super_sub = 1,
            math_symbols = 1,
            sections = 1,
            styles = 1,
        }
    end,
}
