--[[
-- Debug Adapter Protocol client implementation for Neovim.
--]]

local function _(name, opts)
    return function()
        require("dap")[name](opts)
    end
end

local function __conditional_break()
    require("dap").set_breakpoint(vim.fn.input("Condition: "))
end

local function __toggle_repl()
    require("dap").repl.toggle()
end

return {
    "mfussenegger/nvim-dap",
    keys = {
        -- Middle Function Keys
        { "<F5>",  _ "continue",          desc = "DAP Continue" },
        { "<F6>",  _ "terminate",         desc = "DAP Terminate" },
        { "<F7>",  _ "toggle_breakpoint", desc = "DAP Breakpoint" },
        { "<F8>",  __conditional_break,   desc = "DAP Conditional Breakpoint" },
        -- Right Function Keys
        { "<F9>",  __toggle_repl,         desc = "DAP REPL" },
        { "<F10>", _ "step_into",         desc = "DAP Step Into" },
        { "<F11>", _ "step_over",         desc = "DAP Step Over" },
        { "<F12>", _ "step_out",          desc = "DAP Step Out" },
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
                stopOnEntry = true,
                args = {},
                runInTerminal = true,
            }
        }
    end
}
