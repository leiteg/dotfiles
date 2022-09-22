--------------------------------------------------------------------------------
--                               __  _ __   __                                --
--                        __  __/ /_(_) /  / /_  ______ _                     --
--                       / / / / __/ / /  / / / / / __ `/                     --
--                      / /_/ / /_/ / /_ / / /_/ / /_/ /                      --
--                      \__,_/\__/_/_/(_)_/\__,_/\__,_/                       --
--                                                                            --
--------------------------------------------------------------------------------

local M = {}

-- KEYBIND ---------------------------------------------------------------- {{{1

-- General mapping
M.map = function(key, cmd, opts)
    vim.keymap.set('', key, cmd, opts)
end

-- Normal mode mapping
M.nmap = function(key, cmd, opts)
    vim.keymap.set('n', key, cmd, opts)
end

-- Insert mode mapping
M.imap = function(key, cmd, opts)
    vim.keymap.set('i', key, cmd, opts)
end

-- Visual and select mode mapping
M.vmap = function(key, cmd, opts)
    vim.keymap.set('v', key, cmd, opts)
end

-- Visual-only mode mapping
M.xmap = function(key, cmd, opts)
    vim.keymap.set('x', key, cmd, opts)
end

-- Disable keys
M.noop = function(key)
    vim.keymap.set({'i', 'n'}, key, '<nop>')
end

-- AUTOCMD ---------------------------------------------------------------- {{{1

-- }}}

return M
-- vim: nofoldenable
