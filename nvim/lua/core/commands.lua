local open_dotfiles = function()
    vim.cmd [[ tabedit ~/dotfiles ]]
end

local open_plugins = function()
    vim.cmd [[ tabedit ~/dotfiles/nvim/lua/plugins ]]
end

vim.api.nvim_create_user_command("Dotfiles", open_dotfiles, {
    desc = "Open Dotfiles in a new tab.",
})

vim.api.nvim_create_user_command("Plugins", open_plugins, {
    desc = "Open plugins directory in a new tab.",
})
