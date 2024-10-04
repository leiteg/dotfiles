--[[
-- Neovim plugin. Telescope.nvim extension that adds LuaSnip integration.
--]]
return {
    "benfowler/telescope-luasnip.nvim",
    keys = {
        { "<leader>s", "<cmd>Telescope luasnip theme=dropdown<cr>", desc = "Telescope Snippets" },
    },
    config = function()
        require("telescope").load_extension("luasnip")
    end,
}
