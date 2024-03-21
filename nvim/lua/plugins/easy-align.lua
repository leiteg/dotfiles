return {
    "junegunn/vim-easy-align",
    config = function()
        vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', {silent = true})
        vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', {silent = true})
    end,
}
