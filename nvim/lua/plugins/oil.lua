return {
    "stevearc/oil.nvim",
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
            ["<esc>"] = "actions.close"
        }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
