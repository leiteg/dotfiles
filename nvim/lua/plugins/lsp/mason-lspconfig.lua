--[[
-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
--]]
return {
    "williamboman/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            -- Lua
            "lua_ls",
            -- C/C++
            "clangd",
            -- Python
            "ruff",
        },
    },
    config = function(_, opts)
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")

        -- Neovim & nvim-cmp capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        -- HANDLERS --------------------------------------------------------

        -- Default handler used by: lua_ls, ruff.
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

        local function ruff_lsp()
            lspconfig.ruff_lsp.setup {
                capabilities = capabilities,
                on_attach = function(client, _)
                    if client.name == 'ruff_lsp' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                end
            }
        end

        local function pyright()
            lspconfig.pyright.setup {
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { '*' },
                        },
                    },
                },
            }
        end

        -- SETUP -----------------------------------------------------------

        mason_lspconfig.setup(opts)
        mason_lspconfig.setup_handlers {
            -- See `:h mason-lspconfig.setup_handlers()`
            default,
            ["clangd"] = clangd,
            ["rust_analyzer"] = rust_analyzer,
            ["ruff_lsp"] = ruff_lsp,
            ["pyright"] = pyright,
        }
    end
}
