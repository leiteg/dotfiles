return {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
        { "<leader><leader>", "<cmd>tab Git<CR>",               desc = "Git" },
        { "<leader>gc",       "<cmd>tab Git commit<CR>",        desc = "Git commit" },
        { "<leader>gr",       "<cmd>tab Git diff --staged<CR>", desc = "Git diff --staged" },
        { "<leader>gd",       "<cmd>tab Git diff<CR>",          desc = "Git diff" },
        { "<leader>gl",       "<cmd>tab Git log --oneline<CR>", desc = "Git log --oneline" },
        { "<leader>gb",       "<cmd>tab Git blame<CR>",         desc = "Git blame" },
    },
}
