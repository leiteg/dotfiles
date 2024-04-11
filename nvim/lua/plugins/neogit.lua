--[[
-- An interactive and powerful Git interface for Neovim, inspired by Magit.
--]]
return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
        { "<leader><leader>", "<cmd>Neogit<cr>",            desc = "Neogit" },
        { "<leader>gc",       "<cmd>tab Neogit commit<CR>", desc = "Neogit commit" },
        { "<leader>gd",       "<cmd>tab Neogit diff<CR>",   desc = "Neogit diff" },
        { "<leader>gl",       "<cmd>tab Neogit log<CR>",    desc = "Neogit log" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        graph_style = "unicode",
    },
}
