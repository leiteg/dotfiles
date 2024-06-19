--[[
-- An interactive and powerful Git interface for Neovim, inspired by Magit.
--]]

local function _(fn)
    return function()
        require("neogit").open({ fn })
    end
end

return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
        { "<leader><leader>", _(nil),     desc = "Neogit Status" },
        { "<leader>gc",       _ "commit", desc = "Neogit Commit" },
        { "<leader>gd",       _ "diff",   desc = "Neogit Diff" },
        { "<leader>gl",       _ "log",    desc = "Neogit Log" },
    },
    opts = {
        graph_style = "unicode",
        disable_insert_on_commit = true,
        signs = {
          hunk = { "►", "▼" },
          item = { "►", "▼" },
          section = { "►", "▼" },
        },
        commit_editor = {
          kind = "vsplit",
        },
    },
}
