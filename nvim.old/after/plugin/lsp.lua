local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')
local cmp_lsp = require("cmp_nvim_lsp")

-- ATTACH ----------------------------------------------------------------------

-- See :h lsp-zero-keybindings
-- See :h lsp-zero-completion-keybindings
lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

local capabilities = cmp_lsp.default_capabilities()

-- LANGUAGE SERVERS ------------------------------------------------------------

-- C/C++
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
    }
}

-- Python (Ruff)
lspconfig.ruff_lsp.setup {
    capabilities = capabilities,
    init_options = {
        settings = {
            args = {}
        }
    }
}

-- Python (Pyright)
lspconfig.pyright.setup {
    capabilities = capabilities,
}

-- Rust
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
}

-- Lua
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
