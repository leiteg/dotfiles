return {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {}
}
