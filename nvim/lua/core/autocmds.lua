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
autocmd("TextYankPost", {
    group = augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
    end
})

-- Automatically rebalance windows when vim is resized
autocmd("VimResized", {
    group = augroup("ResizeWindow", { clear = true }),
    pattern = "*",
    command = "wincmd ="
})

-- Automatically open quickfix window
autocmd("QuickFixCmdPost", {
    group = augroup("OpenQuickFix", { clear = true }),
    pattern = "*",
    command = "cwindow",
})

-- Jump back to last location in file
autocmd("BufReadPost", {
    group = augroup("JumpLastLocation", { clear = true }),
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

-- Load template from extension on new file
autocmd("BufNewFile", {
    group = augroup("FileTemplates", { clear = true }),
    pattern = "*.*",
    callback = function()
        vim.cmd [[
            silent! execute '0r ~/.config/nvim/templates/template.'.expand("<afile>:e")
            silent! execute 'normal Gddgg'
        ]]
    end,
})

-- Load template from full name on new file
autocmd("BufNewFile", {
    group = augroup("FileTemplates", { clear = false }),
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
