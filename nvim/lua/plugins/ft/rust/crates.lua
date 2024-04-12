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
        { "K",  _ "show_crate_popup",        desc = "Crates Show Crate",         buffer = true },
        { "gv", _ "show_versions_popup",     desc = "Crates Show Versions",      buffer = true },
        { "gf", _ "show_features_popup",     desc = "Crates Show Features",      buffer = true },
        { "gr", _ "show_dependencies_popup", desc = "Crates Show Dependencies",  buffer = true },
        -- Update ------------------------------------------------------------------------------
        { "gu", _ "update_crate",            desc = "Crates Update",             buffer = true },
        { "ga", _ "update_all_crates",       desc = "Crates Update (All)",       buffer = true },
        -- Upgrade -----------------------------------------------------------------------------
        { "gU", _ "upgrade_crate",           desc = "Crates Upgrade",            buffer = true },
        { "gA", _ "upgrade_all_crates",      desc = "Crates Upgrade (All)",      buffer = true },
        -- Documentation -----------------------------------------------------------------------
        { "gd", _ "open_documentation",      desc = "Crates Open Documentation", buffer = true },
        { "gi", _ "open_repository",         desc = "Crates Open Repository",    buffer = true },
    },
}
