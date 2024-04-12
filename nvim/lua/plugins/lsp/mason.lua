return {
    --[[
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    --]]
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
    --[[
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    --]]
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
        },
        config = function(_, opts)
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")

            -- Client capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.tbl_deep_extend("force", capabilities, cmp_capabilities)

            -- HANDLERS --------------------------------------------------------

            local default = function(server_name)
                lspconfig[server_name].setup {
                    capabilities = capabilities,
                }
            end

            local clangd = function()
                lspconfig.clangd.setup {
                    capabilities = capabilities,
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

            local rust_analyzer = function()
                -- Empty. Let `rustaceanvim` handle this.
            end

            -- SETUP -----------------------------------------------------------

            mason_lspconfig.setup(opts)
            mason_lspconfig.setup_handlers {
                -- See `:h mason-lspconfig.setup_handlers()`
                default,
                ["clangd"] = clangd,
                ["rust_analyzer"] = rust_analyzer,
            }
        end
    },
}
