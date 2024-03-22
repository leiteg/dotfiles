return {
    "justinmk/vim-sneak",
    keys = {
        { "s", "<Plug>Sneak_s" },
        { "S", "<Plug>Sneak_S" },
        { "f", "<Plug>Sneak_f" },
        { "F", "<Plug>Sneak_F" },
        { "t", "<Plug>Sneak_t" },
        { "T", "<Plug>Sneak_T" },
    },
    config = function()
        vim.g["sneak#label"] = 1
    end,
}
