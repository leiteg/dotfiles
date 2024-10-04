--[[
-- FZF sorter for telescope written in C.
--]]
return {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    opts = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
    end
}
