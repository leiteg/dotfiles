--[[
-- Debug Adapter Protocol client implementation for Neovim.
--]]

local function dap(name, opts)
    return function()
        require 'dap'[name](opts)
    end
end

local function dap_conditional_breakpoint()
    require 'dap'.set_breakpoint(vim.fn.input("Condition: "))
end

return {
    "mfussenegger/nvim-dap",
    keys = {
        { "<F1>",        dap("toggle_breakpoint"),   desc = "DAP Breakpoint" },
        { "<F5>",        dap("continue"),            desc = "DAP Continue" },
        { "<leader>dc",  dap_conditional_breakpoint, desc = "DAP Conditional Breakpoint" },
        { "<leader>dr",  dap("toggle_repl"),         desc = "DAP REPL" },
        { "<leader>dt",  dap("terminate"),           desc = "DAP Terminate" },
        { "<leader>dsi", dap("step_into"),           desc = "DAP Step Into" },
        { "<leader>dso", dap("step_over"),           desc = "DAP Step Over" },
        { "<leader>dsf", dap("step_out"),            desc = "DAP Step Out" },
    },
    config = function()
        -- Icons
        vim.fn.sign_define('DapBreakpoint', {
            text = " ",
            texthl = "DiagnosticVirtualTextError",
            linehl = "DiagnosticVirtualTextError",
            numhl = "DiagnosticVirtualTextError",
        })
        vim.fn.sign_define('DapBreakpointCondition', {
            text = " ",
            texthl = "DiagnosticVirtualTextWarn",
            linehl = "DiagnosticVirtualTextWarn",
            numhl = "DiagnosticVirtualTextWarn",
        })
        vim.fn.sign_define('DapStopped', {
            text = " ",
            texthl = "DiagnosticVirtualTextHint",
            linehl = "DiagnosticVirtualTextHint",
            numhl = "DiagnosticVirtualTextHint",
        })

        local dap = require("dap")

        -- TODO: Find a way to merge with rustaceanvim
        dap.adapters.codelldb_c = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                args = { "--port", "${port}" },
            },
            name = "codelldb",
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "codelldb_c",
                request = "launch",
                program = function()
                    return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = true,
            }
        }
    end
}
