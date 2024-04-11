--[[
-- Seamless navigation between tmux panes and vim splits.
--]]
return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
    keys = {
        { "<A-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Tmux Navigate Left" },
        { "<A-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Tmux Navigate Down" },
        { "<A-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Tmux Navigate Up" },
        { "<A-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux Navigate Right" },
    },
    init = function()
        -- Disable default mappings (<C-h>, <C-j>, <C-k>, <C-l>).
        vim.cmd [[ let g:tmux_navigator_no_mappings = 1 ]]
    end
}
