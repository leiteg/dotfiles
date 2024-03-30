return {
    "lewis6991/gitsigns.nvim",
    keys = {
        { "<leader>hs", "<cmd>lua require'gitsigns'.stage_hunk()<CR>" },
        { "<leader>hu", "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>" },
        { "<leader>hr", "<cmd>lua require'gitsigns'.reset_hunk()<CR>" },
        { "<leader>td", "<cmd>lua require'gitsigns'.toggle_deleted()<CR>" },
    },
    opts = {},
}
