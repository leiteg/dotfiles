--[[
-- A collection of QoL plugins for Neovim
--]]

local function _(cmd)
    return function()
        require("snacks")[cmd]()
    end
end

local function scratch()
    require("snacks").scratch.open {
        name = "Obsidian Scratchpad",
        file = "~/vaults/second-brain/Scratchpad.md",
        autowrite = true,
        ft = "markdown",
    }
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>bd", _ "bufdelete", desc = "Delete Buffer" },
        { "<leader>,",     scratch,    desc = "Open Scratchpad" },
    },
    opts = {
        -- Deal with bigfiles
        bigfile = { enabled = true },
        -- Delete buffers without disrupting window layout
        bufdelete = { enabled = true },
        -- Indent guides and scopes
        indent = { enabled = true },
        scope = { enabled = true },
        -- Render file as quickly as possible
        quickfile = { enabled = true },
        -- Beautiful declarative dashboards
        dashboard = {
            enabled = true,
            preset = {
                pick = "telescope.nvim",
                keys = {
                    { icon = "", key = "n", desc = "New File",        action = ":enew | startinsert" },
                    { icon = "", key = "p", desc = "Find File",       action = ":TelescopeFiles" },
                    { icon = "󰒲", key = "l", desc = "Open Lazy",       action = ":Lazy" },
                    { icon = "", key = "g", desc = "Open Neogit",     action = ":Neogit" },
                    { icon = "󰧑", key = "o", desc = "Open Obsidian",   action = ":ObsidianQuickSwitch" },
                    { icon = "", key = ",", desc = "Open Scratchpad", action = scratch },
                    { icon = "", key = "r", desc = "Restore Session", action = ":SessionRestore" },
                    { icon = "󰣖", key = ".", desc = "Edit Dotfiles",   action = ":TelescopeDotfiles" },
                    { icon = "󰈆", key = "q", desc = "Quit",            action = ":qa" },
                },
            },
            sections = {
                {
                    section = "terminal",
                    cmd = "chafa ~/dotfiles/assets/ishbel.jpg --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
                    height = 17,
                    padding = 1,
                },
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
            },
        },
        -- A file explorer (picker in disguise)
        explorer = { enabled = false },
        -- Better vim.ui.input
        input = { enabled = false },
        -- Pretty vim.notify
        notifier = { enabled = false },
        -- Picker for selecting items
        picker = { enabled = false },
        -- Smooth scrolling
        scroll = { enabled = false },
        -- Pretty status column
        statuscolumn = { enabled = false },
        -- Auto-show LSP references
        words = { enabled = false },
    },
}
