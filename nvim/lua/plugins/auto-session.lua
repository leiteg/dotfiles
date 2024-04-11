--[[
-- A small automated session manager for Neovim.
--]]
return {
    "rmagatti/auto-session",
    opts = {
        auto_restore_enabled = false,
        auto_save_enabled = true,
        auto_session_supress_dirs = { "/", "/tmp", "~", "~/git", "~/Downloads" },
    },
}
