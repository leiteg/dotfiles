-- [[
-- Obsidian 🤝 Neovim.
-- ]]
return {
    "obsidian-nvim/obsidian.nvim",
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
        notes_subdir = "Notes",
        new_notes_location = "notes_subdir",
        note_id_func = function(title, dir)
            return title
        end,
        templates = {
            enabled = true,
            subdir = "Meta/Templates"
        },
        daily_notes = {
            enabled = false
        },
        frontmatter = {
            enabled = false
        },
        ui = {
            enable = false -- Interferes with render-markdown.nvim
        },
        attachments = {
            folder = "Assets/",
        },
    },
    keys = {
        -- Navigation
        { "<leader>ow", "<cmd>Obsidian workspace<CR>",    desc = "Obsidian Workspace" },
        { "<leader>o/", "<cmd>Obsidian search<CR>",       desc = "Obsidian Search" },
        { "<leader>os", "<cmd>Obsidian quick_switch<CR>", desc = "Obsidian Quick Switch" },
        { "<leader>ol", "<cmd>Obsidian links<CR>",        desc = "Obsidian Links" },
        { "<leader>ob", "<cmd>Obsidian backlinks<CR>",    desc = "Obsidian Backlinks" },
        { "<leader>o#", "<cmd>Obsidian tags<CR>",         desc = "Obsidian Tags" },
        { "<leader>ot", "<cmd>Obsidian toc<CR>",          desc = "Obsidian Toc" },
        -- -- Creation
        { "<leader>on", "<cmd>Obsidian new<CR>",          desc = "Obsidian New" },
        { "<leader>oN", "<cmd>Obsidian template<CR>",     desc = "Obsidian New from Template" },
        { "<leader>oN", "<cmd>Obsidian extract_note<CR>", desc = "Obsidian Extract Note",     mode = "v" },
        { "<leader>ol", "<cmd>Obsidian link<CR>",         desc = "Obsidian Link",             mode = "v" },
        { "<leader>oL", "<cmd>Obsidian link_new<CR>",     desc = "Obsidian Link New",         mode = "v" },
        -- -- Editing
        { "<leader>or", "<cmd>Obsidian rename<CR>",       desc = "Obsidian Rename" },
        { "<leader>op", "<cmd>Obsidian paste_img<CR>",    desc = "Obsidian Paste Image" },
        -- -- Journaling
        -- { "<leader>ot", "<cmd>Obsidian today<CR>",        desc = "Obsidian Today" },
        -- { "<leader>oT", "<cmd>Obsidian tomorrow<CR>",     desc = "Obsidian Tomorrow" },
        -- { "<leader>oy", "<cmd>Obsidian yesterday<CR>",    desc = "Obsidian Yesterday" },
        -- { "<leader>od", "<cmd>Obsidian dailies<CR>",      desc = "Obsidian Dailies" },
    },
    cmd = {
        "Obsidian",
    },
    config = function(_, opts)
        opts = vim.tbl_deep_extend("force", opts, {
            callbacks = {
                enter_note = function(note)
                    local api = require("obsidian.api")
                    local action = require("obsidian.actions")
                    vim.keymap.set("n", "<leader>;", action.add_property, { buffer = true })
                    vim.keymap.set("n", "<tab>", function() action.nav_link "next" end, { buffer = true })
                    vim.keymap.set("n", "<s-tab>", function() action.nav_link "prev" end, { buffer = true })
                end
            }
        })
        require("obsidian").setup(opts)
    end
}
