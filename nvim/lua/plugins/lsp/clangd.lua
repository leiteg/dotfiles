--[[
-- Clangd's off-spec features for neovim's LSP client.
--]]
return {
    "p00f/clangd_extensions.nvim",
    event = "VeryLazy",
    opts = {
        inlay_hints = {
            inline = vim.fn.has("nvim-0.10") == 1,
        },
    },
}
