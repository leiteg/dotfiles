--[[
-- A neovim plugin that helps managing crates.io dependencies.
--]]

local function _(fn, opts)
    return function()
        require("crates")[fn](opts)
    end
end

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
    cmd = "Crates",
    keys = {
        -- Information -------------------------------------------------------------------------
        { "K",  _ "show_crate_popup",        desc = "Crates Show Crate",         ft = "toml" },
        { "gv", _ "show_versions_popup",     desc = "Crates Show Versions",      ft = "toml" },
        { "gf", _ "show_features_popup",     desc = "Crates Show Features",      ft = "toml" },
        { "gr", _ "show_dependencies_popup", desc = "Crates Show Dependencies",  ft = "toml" },
        -- Update ------------------------------------------------------------------------------
        { "gu", _ "update_crate",            desc = "Crates Update",             ft = "toml" },
        { "ga", _ "update_all_crates",       desc = "Crates Update (All)",       ft = "toml" },
        -- Upgrade -----------------------------------------------------------------------------
        { "gU", _ "upgrade_crate",           desc = "Crates Upgrade",            ft = "toml" },
        { "gA", _ "upgrade_all_crates",      desc = "Crates Upgrade (All)",      ft = "toml" },
        -- Documentation -----------------------------------------------------------------------
        { "gd", _ "open_documentation",      desc = "Crates Open Documentation", ft = "toml" },
        { "gi", _ "open_repository",         desc = "Crates Open Repository",    ft = "toml" },
    },
}
