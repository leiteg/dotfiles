return {
    "justinmk/vim-sneak",
    keys = {
        { "s", "<Plug>Sneak_s", desc = "Sneak s" },
        { "S", "<Plug>Sneak_S", desc = "Sneak S" },
        { "f", "<Plug>Sneak_f", desc = "Sneak f" },
        { "F", "<Plug>Sneak_F", desc = "Sneak F" },
        { "t", "<Plug>Sneak_t", desc = "Sneak t" },
        { "T", "<Plug>Sneak_T", desc = "Sneak T" },
    },
    config = function()
        vim.g["sneak#label"] = 1
    end,
}
