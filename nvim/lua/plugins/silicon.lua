return {
    "krivahtoo/silicon.nvim",
    lazy = true,
    cmd = "Silicon",
    init = function()
        vim.keymap.set("v", "<leader>ss", "<cmd>'<,'>Silicon<CR>", {
            desc = "Take a screenshot of selected text with Silicon."
        })

        vim.keymap.set("n", "<leader>ss", "<cmd>%Silicon<CR>", {
            desc = "Take a screenshot entire file with Silicon."
        })
    end,
    config = function()
        require("silicon").setup({
            font = "Iosevka Term",
            theme = "Dracula",
            background = "#ffffff00",
            line_number = true,
            pad_horiz = 5,
            pad_vert = 5,
        })
    end,
}
