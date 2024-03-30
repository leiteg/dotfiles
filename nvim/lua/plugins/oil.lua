return {
    "stevearc/oil.nvim",
    lazy = false,
    cmd = "Oil",
    keys = {
        { "-", "<cmd>Oil --float<CR>" }
    },
    opts = {
        float = {
            padding = 5,
            max_width = 60,
            max_height = 25,

        },
        keymaps = {
            ["<esc>"] = "actions.close",
            ["q"] = "actions.close",
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
