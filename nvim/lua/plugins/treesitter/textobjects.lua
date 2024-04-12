--[[
-- Syntax aware text-objects, select, move, swap, and peek support.
--]]

-- SELECT ------------------------------------------------------------------------------------------

local select_opts = {
    enable = true,
    lookahead = true,
    keymaps = {
        ["a="] = "@assignment.outer",
        ["i="] = "@assignment.inner",
        ["l="] = "@assignment.lhs",
        ["r="] = "@assignment.rhs",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["aS"] = "@statement.outer",
        ["iS"] = "@statement.inner",
    },
}

-- SWAP --------------------------------------------------------------------------------------------

local swap_opts = {
    enable = true,
    swap_next = {
        ["<leader>aj"] = "@parameter.inner",
        ["<leader>fj"] = "@toplevel",
    },
    swap_previous = {
        ["<leader>ak"] = "@parameter.inner",
        ["<leader>fk"] = "@toplevel",
    },
}

-- MOVE --------------------------------------------------------------------------------------------

local move_opts = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
        ["]f"] = "@toplevel",
        ["]a"] = "@parameter.inner",
    },
    goto_next_end = {
        ["]F"] = "@toplevel",
        ["]A"] = "@parameter.inner",
    },
    goto_previous_start = {
        ["[f"] = "@toplevel",
        ["[a"] = "@parameter.inner",
    },
    goto_previous_end = {
        ["[F"] = "@toplevel",
        ["[A"] = "@parameter.inner",
    },
}

-- LSP ---------------------------------------------------------------------------------------------

local lsp_opts = {
    enable = true,
    border = 'none',
    floating_preview_opts = {},
    peek_definition_code = {
        ["<leader>fp"] = "@function.outer",
        ["<leader>cp"] = "@class.outer",
    }
}

return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = {
        textobjects = {
            select = select_opts,
            swap = swap_opts,
            move = move_opts,
            lsp_interop = lsp_opts,
        },
        -- Added just to satisfy type-checker.
        modules = {},
        sync_install = false,
        ensure_installed = {},
        auto_install = false,
        ignore_install = {},
        parser_install_dir = nil,
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
