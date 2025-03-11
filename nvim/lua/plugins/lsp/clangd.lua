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
    keys = {
        { "<leader>cth", "<cmd>ClangdTypeHierarchy<CR>",      desc = "Clangd show type hierarchy" },
        { "<leader>csh", "<cmd>ClangdSwitchSourceHeader<CR>", desc = "Clangd switch source header" },
        { "<leader>cas", "<cmd>ClangdAST<CR>",                desc = "Clangd show AST" },
    }
}
