--[[ -----------------------------------------------------------------------------------------------
-- MINIMAL NEOVIM CONFIGURATION FOR TROUBLESHOOTING.
--]] -----------------------------------------------------------------------------------------------

-- LAZY BOOSTRAP -----------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- PACKAGES ----------------------------------------------------------------------------------------

require("lazy").setup({
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                ensure_installed = { "clangd", "pyright", "ruff" }
            })

            -- Just print a message and call `setup` with default (empty) options.
            local function default_setup(server)
                return function()
                    print(string.format("MasonLspConfig: Setup for '%s'", server))
                    lspconfig[server].setup({})
                end
            end

            mason_lspconfig.setup_handlers({
                ["clangd"] = default_setup("clangd"),
                ["pyright"] = default_setup("pyright"),
                ["ruff"] = default_setup("ruff"),
            })
        end
    },
})

-- ADDITIONAL CONFIG -------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
    callback = function(event)
        -- Print message
        print(string.format(
            "LspAttach: buffer=%s, event=%s",
            vim.api.nvim_get_current_buf(),
            vim.inspect(event)
        ))

        -- Setup some keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
    end
})

-- vim: et sts=4 sw=4
