--------------------------------------------------------------------------------
--                    __                           __       __                --
--       ____ ___  __/ /_____  _________ ___  ____/ /____  / /_  ______ _     --
--      / __ `/ / / / __/ __ \/ ___/ __ `__ \/ __  / ___/ / / / / / __ `/     --
--     / /_/ / /_/ / /_/ /_/ / /__/ / / / / / /_/ (__  ) / / /_/ / /_/ /      --
--     \__,_/\__,_/\__/\____/\___/_/ /_/ /_/\__,_/____(_)_/\__,_/\__,_/       --
--                                                                            --
--------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text for a short period
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
    end
})

-- Automatically rebalance windows when vim is resized
augroup("ResizeWindow", { clear = true })
autocmd("VimResized", {
    group = "ResizeWindow",
    pattern = "*",
    command = "wincmd ="
})

-- Automatically open quickfix window
augroup("OpenQuickFix", { clear = true })
autocmd("QuickFixCmdPost", {
    group = "OpenQuickFix",
    pattern = "*",
    command = "cwindow",
})

-- Jump back to last location in file
augroup("JumpLastLocation", { clear = true })
autocmd("BufReadPost", {
    group = "JumpLastLocation",
    callback = function()
        local fname = vim.fn.expand("%:t")
        if fname == "COMMIT_EDITMSG" then
            return
        end
        local line = vim.fn.line("'\"")
        local last = vim.fn.line("$")
        if line >= 1 and line <= last then
            vim.cmd [[execute "normal! g`\"zz"]]
        end
    end
})

-- Load template when opening new file
augroup("FileTemplates", { clear = true })
autocmd("BufNewFile", {
    group = "FileTemplates",
    pattern = "*.*",
    callback = function()
        vim.cmd [[
            silent! execute '0r ~/.config/nvim/templates/template.'.expand("<afile>:e")
            silent! execute 'normal Gddgg'
        ]]
    end,
})
autocmd("BufNewFile", {
    group = "FileTemplates",
    pattern = {
        "pyproject.toml",
        "CMakeLists.txt",
        "CMakePresets.json",
        ".pre-commit-config.yaml",
    },
    callback = function()
        vim.cmd [[
            silent! execute '0r ~/.config/nvim/templates/'.expand("<afile>:t")
            silent! execute 'normal Gddgg'
        ]]
    end,
})
