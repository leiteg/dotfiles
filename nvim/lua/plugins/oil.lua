return {
    "stevearc/oil.nvim",
    cmd = "Oil",
    init = function()
        vim.keymap.set("n", "-", "<CMD>Oil<CR>")
    end,
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
