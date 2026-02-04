--[[
-- Virtualize debugging sessions in neovim.
--]]
return {
    "igorlfs/nvim-dap-view",
    keys = {
        { "<leader>dd", "<cmd>DapViewToggle<CR>" },
    },
    opts = {},
}
