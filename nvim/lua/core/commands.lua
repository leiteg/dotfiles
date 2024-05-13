--------------------------------------------------------------------------------
--                                                    __       __             --
--    _________  ____ ___  ____ ___  ____ _____  ____/ /____  / /_  ______ _  --
--   / ___/ __ \/ __ `__ \/ __ `__ \/ __ `/ __ \/ __  / ___/ / / / / / __ `/  --
--  / /__/ /_/ / / / / / / / / / / / /_/ / / / / /_/ (__  ) / / /_/ / /_/ /   --
--  \___/\____/_/ /_/ /_/_/ /_/ /_/\__,_/_/ /_/\__,_/____(_)_/\__,_/\__,_/    --
--                                                                            --
--------------------------------------------------------------------------------

vim.api.nvim_create_user_command("Dotfiles", function()
    vim.cmd [[ tabedit ~/dotfiles ]]
end, { desc = "Open Dotfiles in a new tab.", })

vim.api.nvim_create_user_command("Plugins", function()
    vim.cmd [[ tabedit ~/dotfiles/nvim/lua/plugins ]]
end, { desc = "Open plugins directory in a new tab.", })
