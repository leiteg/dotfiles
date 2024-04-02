local handler_default = function(server_name)
    require("lspconfig")[server_name].setup({})
end

local handler_lua_ls = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "require" }
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    }
end

local handler_clangd = function()
    local lspconfig = require("lspconfig")
    lspconfig.clangd.setup {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--header-insertion=iwyu",
            "--suggest-missing-includes",
        },
    }
end

return {
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = " ",
                    package_pending = " ",
                    package_uninstalled = " ",
                }
            }
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "pyright",
                "ruff_lsp",
                "rust_analyzer",
                "lua_ls",
            },
            -- See `:h mason-lspconfig.setup_handlers()`
            handlers = {
                handler_default,
                ["lua_ls"] = handler_lua_ls,
                ["clangd"] = handler_clangd,
            },
        },
    },
}
