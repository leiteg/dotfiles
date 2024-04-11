--[[
-- A neovim plugin that helps managing crates.io dependencies.
--]]
return {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
        text = {
            loading = "  Loading ",
            version = "  %s ",
            prerelease = "  %s ",
            yanked = "  %s ",
            nomatch = "  No match ",
            upgrade = "  %s ",
            error = "  Error fetching crate ",
        },
    },
    config = function(_, opts)
        local crates = require("crates")
        crates.setup(opts)

        local opts = {
            silent = true,
            buffer = true,
        }

        -- Information
        vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
        vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
        -- Update
        vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
        vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
        vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
        -- Upgrade
        vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
        vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
        vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)
        -- Docs
        vim.keymap.set("n", "<CR>", crates.open_documentation, opts)
        vim.keymap.set("n", "<leader>cd", crates.open_documentation, opts)
        vim.keymap.set("n", "<leader>cr", crates.open_repository, opts)
        vim.keymap.set("n", "<leader>ch", crates.open_homepage, opts)
    end
}
