--[[
-- A lua powered greeter like vim-startify / dashboard-nvim.
--]]
return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local version = vim.version()

        -- dashboard.section.header.val = {
        --     "                                                     ",
        --     "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        --     "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        --     "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        --     "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        --     "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        --     "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        --     "                                                     ",
        -- }

        dashboard.section.buttons.val = {
            dashboard.button("n", "  New File", "<cmd>enew<CR>"),
            dashboard.button("f", "  Find File", "<cmd>TelescopeFiles<CR>"),
            dashboard.button("l", "󰒲  Open Lazy", "<cmd>Lazy<CR>"),
            dashboard.button("g", "  Open Neogit", "<cmd>Neogit<CR>"),
            dashboard.button("r", "  Restore Session", "<cmd>SessionRestore<CR>"),
            dashboard.button("c", "󰣖  Edit Config", "<cmd>edit ~/.config/nvim<CR>"),
            dashboard.button("q", "󰈆  Quit", "<cmd>qa<CR>"),
        }

        dashboard.section.footer.val = {
            string.format("Neovim v%s.%s.%s", version.major, version.minor, version.patch)
        }

        alpha.setup(dashboard.opts)
    end,
}
