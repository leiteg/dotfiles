local config = function()
    local lsp_zero = require("lsp-zero").preset({})
    local lspconfig = require("lspconfig")

    -- :h lsp-zero-keybindings
    -- :h lsp-zero-completion-keybindings
    lsp_zero.on_attach(function(_, buffer)
        lsp_zero.default_keymaps({ buffer = buffer })
    end)

    require("mason").setup {}
    require("mason-lspconfig").setup {
        ensure_installed = {},
        handlers = {
            lsp_zero.default_setup
        }
    }

    lspconfig.clangd.setup {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=bundled",
            "--cross-file-rename",
            "--header-insertion=iwyu",
            "--suggest-missing-includes",
        }
    }

    lspconfig.ruff_lsp.setup {
        init_options = {
            settings = {
                args = {}
            }
        }
    }

    lspconfig.lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        "vim",
                        "require",
                    }
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    }

    lspconfig.pyright.setup {}
    lspconfig.rust_analyzer.setup {}
    lsp_zero.setup()
end

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
    },
    config = config,
}
