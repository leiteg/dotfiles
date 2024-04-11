--[[
-- Debug Adapter Protocol client implementation for Neovim.
--]]

local function dap_continue()
    require 'dap'.continue()
end

local function dap_toggle_breakpoint()
    require 'dap'.toggle_breakpoint()
end

local function dap_conditional_breakpoint()
    require 'dap'.set_breakpoint(vim.fn.input("Condition: "))
end

local function dap_toggle_repl()
    require 'dap'.toggle_repl()
end

local function dap_terminate()
    require 'dap'.terminate()
end

local function dap_step_into()
    require 'dap'.step_into()
end

local function dap_step_over()
    require 'dap'.step_over()
end

local function dap_step_out()
    require 'dap'.step_out()
end

return {
    "mfussenegger/nvim-dap",
    keys = {
        { "<F5>",        dap_continue,               desc = "DAP Continue" },
        { "<F1>",        dap_toggle_breakpoint,      desc = "DAP Breakpoint" },
        { "<leader>dc",  dap_conditional_breakpoint, desc = "DAP Conditional Breakpoint" },
        { "<leader>dr",  dap_toggle_repl,            desc = "DAP REPL" },
        { "<leader>dt",  dap_terminate,              desc = "DAP Terminate" },
        { "<leader>dsi", dap_step_into,              desc = "DAP Step Into" },
        { "<leader>dso", dap_step_over,              desc = "DAP Step Over" },
        { "<leader>dsf", dap_step_out,               desc = "DAP Step Out" },
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
