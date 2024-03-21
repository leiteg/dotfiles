return {
    "sirver/ultisnips",
    init = function()
        vim.g.UltiSnipsEditSplit = "vertical"
        vim.g.UltiSnipsSnippetDirectories = { "snips" }
        vim.g.UltiSnipsExpandTrigger = "<c-l>"
        vim.g.UltiSnipsListSnippets = "<c-tab>"
        vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
        vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
    end,
}
