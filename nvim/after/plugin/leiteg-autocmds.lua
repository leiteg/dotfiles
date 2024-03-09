local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text for a short period
augroup("YankHighlight", {clear = true})
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({higroup = "IncSearch", timeout = "150"})
    end
})

-- Automatically rebalance windows when vim is resized
augroup("ResizeWindow", {clear = true})
autocmd("VimResized", {
    group = "ResizeWindow",
    pattern = "*",
    command = "wincmd ="
})

-- Automatically open quickfix window
augroup("OpenQuickFix", {clear = true})
autocmd("QuickFixCmdPost", {
    group = "OpenQuickFix",
    pattern = "*",
    command = "cwindow",
})

-- Jump back to last location in file
augroup("JumpLastLocation", {clear = true})
autocmd("BufReadPost", {
    group = "JumpLastLocation",
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "gitcommit" then
            return
        end
        local line = vim.fn.line("'\"")
        local last = vim.fn.line("$")
        if line >= 1 and line <= last then
            vim.cmd[[execute "normal! g`\"zz"]]
        end
    end
})
