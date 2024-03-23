return {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
        { "<leader><leader>", "<cmd>vert Git<CR>" },
        { "<leader>gc",       "<cmd>tab Git commit<CR>" },
        { "<leader>gr",       "<cmd>tab Git diff --staged<CR>" },
        { "<leader>gd",       "<cmd>tab Git diff<CR>" },
        { "<leader>gl",       "<cmd>tab Git log --oneline<CR>" },
        { "<leader>gb",       "<cmd>tab Git blame<CR>" },
    },
}
