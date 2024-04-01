return {
    'stevearc/aerial.nvim',
    lazy = false,
    opts = {},
    keys = {
        { "<leader>q", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" }
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
}
