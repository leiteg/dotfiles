local silicon = require("silicon")

silicon.setup({
    font = "Iosevka Term",
    theme = "Dracula",
    background = "#ffffff00",
    line_number = true,
    pad_horiz = 5,
    pad_vert = 5,
})

vim.keymap.set("v", "<leader>ss", "<cmd>Silicon<CR>", {
    desc = "Take a screenshot with Silicon."
})
