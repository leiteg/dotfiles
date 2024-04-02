local function dapui_toggle()
    require 'dapui'.toggle()
end

return {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        { "<leader>dd", dapui_toggle, desc = "DAPUI Toggle" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup({})

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
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end
}
