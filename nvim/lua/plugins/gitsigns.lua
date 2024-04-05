return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    keys = {
        { "<leader>hs", "<cmd>lua require'gitsigns'.stage_hunk()<CR>",      desc = "Stage hunk" },
        { "<leader>hu", "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>", desc = "Undo stage hunk" },
        { "<leader>hr", "<cmd>lua require'gitsigns'.reset_hunk()<CR>",      desc = "Reset hunk" },
        { "<leader>td", "<cmd>lua require'gitsigns'.toggle_deleted()<CR>",  desc = "Toggle deleted lines" },
    },
    opts = {},
}
