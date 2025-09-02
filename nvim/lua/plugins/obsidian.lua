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
            {
                name = "blog",
                path = "~/vaults/blog/",
                overrides = {
                    notes_subdir = "posts",
                    daily_notes = {
                        folder = vim.NIL,
                    },
                    templates = {
                        subdir = "templates/",
                    },
                    attachments = {
                        img_folder = "assets/",
                    },
                },
            },
        },
        daily_notes = {
            folder = "Daily/",
            date_format = "/%Y/%m/%Y-%m-%d",
            template = "New Daily",
        },
        templates = { subdir = "Meta/Templates" },
        notes_subdir = "Notes",
        new_notes_location = "notes_subdir",
        disable_frontmatter = true,
        note_id_func = function(title)
            return title
        end,
        mappings = {
            ["<C-Space>"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
            ["[a"] = {
                action = function()
                    return vim.fn.search("[[", "bsW")
                end,
                opts = { buffer = true },
            },
            ["]a"] = {
                action = function()
                    return vim.fn.search("[[", "sW")
                end,
                opts = { buffer = true },
            },
        },
        attachments = {
            img_folder = "Assets/",
        },
        -- Interferes with render-markdown.nvim
        ui = { enable = false },
    },
    keys = {
        -- Navigation
        { "<leader>ow", "<cmd>ObsidianWorkspace<CR>",   desc = "Obsidian Workspace" },
        { "<leader>o/", "<cmd>ObsidianSearch<CR>",      desc = "Obsidian Search" },
        { "<leader>os", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
        { "<leader>ol", "<cmd>ObsidianLinks<CR>",       desc = "Obsidian Links" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<CR>",   desc = "Obsidian Backlinks" },
        { "<leader>o#", "<cmd>ObsidianTags<CR>",        desc = "Obsidian Tags" },
        { "<CR>",       "<cmd>ObsidianFollowLink<CR>",  desc = "Obsidian Follow Link" },
        -- Creation
        { "<leader>on", "<cmd>ObsidianNew<CR>",         desc = "Obsidian New" },
        { "<leader>oN", "<cmd>ObsidianTemplate<CR>",    desc = "Obsidian New from Template" },
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
        "ObsidianTemplate"
    },
}
