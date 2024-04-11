--[[
-- Supercharge your Rust experience in Neovim! A heavily modified fork of
-- rust-tools.nvim.
--]]
return {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    }
}
