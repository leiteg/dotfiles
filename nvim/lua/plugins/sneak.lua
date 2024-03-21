return {
    "justinmk/vim-sneak",
    keys = {
        { "f", "<Plug>Sneak_f" },
        { "F", "<Plug>Sneak_F" },
        { "t", "<Plug>Sneak_t" },
        { "T", "<Plug>Sneak_T" },
    },
    config = function()
        vim.g["sneak#label"] = 1
    end,
}
