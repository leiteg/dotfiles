--------------------------------------------------------------------------------
--                      __                           __   __                  --
--         ____ ___  __/ /_____  _________ ___  ____/ /  / /_  ______ _       --
--        / __ `/ / / / __/ __ \/ ___/ __ `__ \/ __  /  / / / / / __ `/       --
--       / /_/ / /_/ / /_/ /_/ / /__/ / / / / / /_/ /_ / / /_/ / /_/ /        --
--       \__,_/\__,_/\__/\____/\___/_/ /_/ /_/\__,_/(_)_/\__,_/\__,_/         --
--                                                                            --
--------------------------------------------------------------------------------

-- Recompile Packer when changing file
vim.cmd [[
augroup MyPackerCompile
    autocmd!
    autocmd BufWritePost */leiteg/*.lua
            \ source <afile>
    autocmd BufWritePost */leiteg/plugin.lua
            \ echom "Recompiling..." | PackerCompile
augroup end
]]

-- Open quickfix window if there are any errors
vim.cmd [[
augroup QuickFix
    autocmd!
    autocmd QuickFixCmdPost * cwindow
augroup END
]]

-- Jump to last location when opening a file
vim.cmd [[
augroup JumpLastLocation
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END
]]

-- Balance vim windows when enclosing Tmux pane is resized
vim.cmd [[
augroup ResizeWindows
    autocmd!
    autocmd VimResized * wincmd =
augroup END
]]

-- Show colorcolumn only in insert mode
vim.cmd [[
augroup ColorColumnInsertMode
    autocmd!
    autocmd InsertEnter * set colorcolumn=+1
    autocmd InsertLeave * set colorcolumn=0
augroup END
]]

-- Load templates when opening a new file
vim.cmd [[
augroup FileTemplates
    autocmd!
    autocmd BufNewFile *.*
          \ silent! execute '0r ~/.config/nvim/templates/skeleton.'.expand("<afile>:e").' 
          \ | normal Gddgg'
augroup END
]]

-- Highlight yanked text
vim.cmd [[
augroup Highlightyank
    autocmd!
    autocmd TextYankPost *
          \ silent! lua vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
augroup END
]]

-- Highlight trailing whitespace
vim.cmd [[
hi    ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

augroup Whitespace
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call  clearmatches()
augroup END
]]
