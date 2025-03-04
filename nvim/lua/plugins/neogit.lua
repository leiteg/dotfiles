--[[
-- An interactive and powerful Git interface for Neovim, inspired by Magit.
--]]

local function neogit(fn)
    require("neogit").open(fn)
end

local function open() neogit { kind = "floating" } end
local function commit() neogit { "commit" } end
local function diff() neogit { "diff" } end
local function log() neogit { "log" } end

local function logcurr()
    require("neogit").action("log", "log_current", {
        "--graph",
        "--decorate",
        "--",
        vim.fn.expand("%"),
    })()
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
        { "<leader><leader>", open,    desc = "Neogit Status" },
        { "<leader>gc",       commit,  desc = "Neogit Commit" },
        { "<leader>gd",       diff,    desc = "Neogit Diff" },
        { "<leader>gL",       log,     desc = "Neogit Log" },
        { "<leader>gl",       logcurr, desc = "Neogit Log Current File" },
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
            kind = "tab",
            staged_diff_split_kind = "auto",
        },
        rebase_editor = {
            kind = "tab",
        }
    },
}
