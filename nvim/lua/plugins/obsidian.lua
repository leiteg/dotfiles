-- [[
-- Obsidian 🤝 Neovim.
-- ]]
return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "second-brain",
                path = "~/vaults/second-brain/",
            },
        },
        daily_notes = {
            folder = "Journal/",
            date_format = "/%Y/%m/%Y-%m-%d",
            template = "Daily",
        },
        templates = { subdir = "Templates" },
        notes_subdir = "Notes",
        new_notes_location = "notes_subdir",
        disable_frontmatter = true,
    },
    keys = {
        -- Navigation
        { "<leader>os", "<cmd>ObsidianSearch<CR>",      desc = "Obsidian Search" },
        { "<leader>oS", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
        { "<leader>ol", "<cmd>ObsidianLinks<CR>",       desc = "Obsidian Links" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<CR>",   desc = "Obsidian Backlinks" },
        { "<leader>o#", "<cmd>ObsidianTags<CR>",        desc = "Obsidian Tags" },
        -- Creation
        { "<leader>on", "<cmd>ObsidianNew<CR>",         desc = "Obsidian New" },
        { "<leader>oN", "<cmd>ObsidianExtractNote<CR>", desc = "Obsidian Extract Note", mode = "v" },
        { "<leader>ol", "<cmd>ObsidianLink<CR>",        desc = "Obsidian Link",         mode = "v" },
        { "<leader>oL", "<cmd>ObsidianLinkNew<CR>",     desc = "Obsidian Link New",     mode = "v" },
        -- Editing
        { "<leader>or", "<cmd>ObsidianRename<CR>",      desc = "Obsidian Rename" },
        { "<leader>op", "<cmd>ObsidianPasteImg<CR>",    desc = "Obsidian Paste Image" },
        -- Journaling
        { "<leader>ot", "<cmd>ObsidianToday<CR>",       desc = "Obsidian Today" },
        { "<leader>oT", "<cmd>ObsidianTomorrow<CR>",    desc = "Obsidian Tomorrow" },
        { "<leader>oy", "<cmd>ObsidianYesterday<CR>",   desc = "Obsidian Yesterday" },
        { "<leader>od", "<cmd>ObsidianDailies<CR>",     desc = "Obsidian Dailies" },
    },
    cmd = {
        "ObsidianBacklinks",
        "ObsidianDailies",
        "ObsidianExtractNote",
        "ObsidianFollowLink",
        "ObsidianLink",
        "ObsidianLinkNew",
        "ObsidianLinks",
        "ObsidianNew",
        "ObsidianOpen",
        "ObsidianPasteImg",
        "ObsidianQuickSwitch",
        "ObsidianRename",
        "ObsidianSearch",
        "ObsidianTags",
        "ObsidianTemplate",
        "ObsidianToday",
        "ObsidianToggleCheckbox",
        "ObsidianTomorrow",
        "ObsidianWorkspace",
        "ObsidianYesterday",
    },
}
