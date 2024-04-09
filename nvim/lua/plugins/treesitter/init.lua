return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python" },
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
        }
    end,
}
