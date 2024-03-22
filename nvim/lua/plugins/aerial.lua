return {
    'stevearc/aerial.nvim',
    lazy = false,
    opts = {},
    keys = {
        { "<leader>q", "<cmd>AerialToggle<CR>" }
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
}
