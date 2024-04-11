--[[
-- Highly experimental plugin that completely replaces the UI for messages,
-- cmdline and the popupmenu.
--]]
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        messages = {
            enabled = false,
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                render = "minimal",
                stages = "fade",
                timeout = 1000,
            },
        },
    },
}
