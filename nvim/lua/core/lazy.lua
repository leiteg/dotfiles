--------------------------------------------------------------------------------
--                       __                    __                             --
--                      / /___ _____  __  __  / /_  ______ _                  --
--                     / / __ `/_  / / / / / / / / / / __ `/                  --
--                    / / /_/ / / /_/ /_/ / / / /_/ / /_/ /                   --
--                   /_/\__,_/ /___/\__, (_)_/\__,_/\__,_/                    --
--                                 /____/                                     --
--                                                                            --
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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

-- Where to look for plugins
local plugins = {
    -- General purpose plugins
    { import = "plugins" },
    -- Plugins from the mini.nvim bundle
    { import = "plugins.mini" },
    -- Treesitter-related
    { import = "plugins.treesitter" },
    -- Telescope-related
    { import = "plugins.telescope" },
    -- Language Server Protocol related
    { import = "plugins.lsp" },
    -- Debug Adapter Protocol related
    { import = "plugins.dap" },
    -- Plugins by filetype
    { import = "plugins.ft" },
    -- Local plugins for testing
    { import = "plugins.local" },
}

-- General options
local opts = {
    install = {
        coloscheme = { "tokyonight" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    dev = {
        path = "~/git/neovim",
    },
    ui = {
        icons = {
            loaded = " ",
            not_loaded = " "
        },
    }
}

require("lazy").setup(plugins, opts)

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Open Lazy UI" })
