local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

-- See :h lsp-zero-keybindings
-- See :h lsp-zero-completion-keybindings
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

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

lsp.setup()
