--------------------------------------------------------------------------------
--                                                 __                         --
--                  ____  ___  ____  _________ _  / /_  ______ _              --
--                 / __ \/ _ \/ __ \/ ___/ __ `/ / / / / / __ `/              --
--                / / / /  __/ /_/ / /  / /_/ / / / /_/ / /_/ /               --
--               /_/ /_/\___/\____/_/   \__, (_)_/\__,_/\__,_/                --
--                                     /____/                                 --
--                                                                            --
--------------------------------------------------------------------------------

local M = {}

M.config = function()
    require('neorg').setup {
        load = {
            ["core.defaults"] = {},
            ["core.gtd.base"] = {
                config = {
                    workspace = "life",
                }
            },
            ["core.norg.journal"] = {
                config = {
                    workspace = "life",
                    journal_folder = "journal",
                }
            },
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        everything = "~/git/everything",
                        life = "~/life",
                    }
                }
            },
            ["core.norg.concealer"] = {},
            ["external.kanban"] = {},

            -- ["core.export"] = {},
            -- ["core.export.markdown"] = {},
        }
    }

    local map_ = vim.keymap.set
    map_('n', '<leader>jj', ':Neorg journal today<CR>', {silent=true})
    map_('n', '<leader>tq', ':Neorg gtd capture<CR>',   {silent=true})
    map_('n', '<leader>ts', ':Neorg gtd views<CR>',     {silent=true})
    map_('n', '<leader>te', ':Neorg gtd edit<CR>',      {silent=true})
    map_('n', '<leader>tk', ':Neorg kanban toggle<CR>', {silent=true})

end

return M
