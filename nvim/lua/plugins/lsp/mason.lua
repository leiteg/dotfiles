--[[
-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
--]]
return {
    "williamboman/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = " ",
                package_pending = " ",
                package_uninstalled = " ",
            }
        }
    },
}
