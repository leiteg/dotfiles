--[[
-- Nvim Treesitter configurations and abstraction layer.
--]]
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python", "mlir" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            disable = { "tex", "latex" },
        },
        indent = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                node_incremental = "+",
                node_decremental = "-",
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
