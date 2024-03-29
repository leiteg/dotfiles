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
    { import = "plugins" },
    { import = "plugins.mini" },
    { import = "plugins.treesitter" },
}

-- General options
local opts = {
    install = {
        coloscheme = { "dracula" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    }
}

require("lazy").setup(plugins, opts)
