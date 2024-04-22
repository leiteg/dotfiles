--[[
-- Modernity meets insane extensibility. The future of organizing your life in Neovim.
--]]
return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = {
        "luarocks.nvim",
        "nvim-lua/plenary.nvim",
    },
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
                config = {
                    default_workspace = "neorg",
                    index = "index.norg",
                    workspaces = {
                        neorg = "~/vaults/neorg",
                    },
                },
            },
            ["core.summary"] = {},
        },
    },
    keys = {
        { "<leader>nn", "<cmd>Neorg index<CR>",             desc = "Neorg Index" },
        { "<leader>nt", "<cmd>Neorg journal today<CR>",     desc = "Neorg Journal Today" },
        { "<leader>ny", "<cmd>Neorg journal yesterday<CR>", desc = "Neorg Journal Yesterday" },
        { "<leader>nT", "<cmd>Neorg journal tomorrow<CR>",  desc = "Neorg Journal Tomorrow" },
    },
}
