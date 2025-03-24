--[[
-- A UI for nvim-dap.
--]]

local function _(fn)
    return function()
        require("dapui")[fn]()
    end
end

return {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        { "<leader>dd", _ "toggle", desc = "DAPUI Toggle" },
    },
    opts = {
        layouts = { {
            elements = { {
                id = "scopes",
                size = 0.30
            }, {
                id = "watches",
                size = 0.30
            }, {
                id = "stacks",
                size = 0.40
            } },
            position = "right",
            size = 80
        }, {
            elements = { {
                id = "console",
                size = 1.0
            } },
            position = "bottom",
            size = 20
        } },
    },
    config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup(opts)

        -- Automatically open DAPUI when debugging session start
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        -- Automatically open DAPUI when debugging session ends
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        -- dap.listeners.before.event_exited.dapui_config = function()
        --     dapui.close()
        -- end
    end
}
