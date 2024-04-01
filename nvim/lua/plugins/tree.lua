return {
    "nvim-tree/nvim-tree.lua",
    cmd = {
        "NvimTreeToggle",
        "NvimTreeFindFile",
    },
    keys = {
        { "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle Nvim Tree" },
    },
    opts = {
        filters = {
            git_ignored = false,
        },
        renderer = {
            icons = {
                git_placement = "signcolumn",
                glyphs = {
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "󱨧",
                        untracked = "",
                        deleted = "",
                        ignored = "",
                    },
                },
            },
        },
    },
}
