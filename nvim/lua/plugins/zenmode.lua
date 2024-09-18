-- [[
--🧘 Distraction-free coding for Neovim.
-- ]]

local function zen_mode_toggle()
    require "zen-mode".toggle()
end

return {
    "folke/zen-mode.nvim",
    opts = {
        plugins = {
            tmux = { enabled = true },
            alacritty = { enabled = true },
        },
    },
    keys = {
        { "<leader>z", zen_mode_toggle, desc = "ZenMode Toggle" },
    },
}
