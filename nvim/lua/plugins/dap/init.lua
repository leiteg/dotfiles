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

local function __hover()
    require("dap.ui.widgets").hover()
end

return {
    "mfussenegger/nvim-dap",
    keys = {
        { "<leader>db", _ "toggle_breakpoint", desc = "DAP Breakpoint" },
        { "<leader>dB", __conditional_break,   desc = "DAP Conditional Breakpoint" },
        { "<leader>ds", _ "continue",          desc = "DAP Continue" },
        { "<leader>dT", _ "terminate",         desc = "DAP Terminate" },
        { "<leader>d.", _ "run_to_cursor",     desc = "DAP Run to cursor" },
        { "<leader>dh", __hover,               desc = "DAP Hover" },
        { "<leader>dr", __toggle_repl,         desc = "DAP REPL" },
        { "<leader>dj", _ "down",              desc = "DAP Stack Frame Down"},
        { "<leader>dk", _ "up",                desc = "DAP Stack Frame Up"},
        { "<leader>dg", _ "goto_",             desc = "DAP Goto"},
        { "<F10>",      _ "step_into",         desc = "DAP Step Into" },
        { "<F11>",      _ "step_over",         desc = "DAP Step Over" },
        { "<F12>",      _ "step_out",          desc = "DAP Step Out" },
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

        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                args = function()
                    return vim.split(vim.fn.input("Arguments: "), " +")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = true,
                runInTerminal = true,
            }
        }
    end
}
