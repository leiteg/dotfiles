require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },

    textobjects = {

        -- Selection of new text objects (i.e. function, class)
        select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
            -- Which selection mode (e.g. v, V, <c-v>) to use.
            selection_modes = {
                ["@function.outer"] = "V",
                ["@function.inner"] = "V",
                ["@class.outer"] = "V",
                ["@class.inner"] = "v",
            },
        },

        -- Swap AST nodes.
        swap = {
            enable = false,
            swap_next = {
                ["<leader>a"] = "@function.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@funcion.inner",
            },
        },

        -- Move around file.
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
            },
        },

        -- Shows a floating window with preview.
        lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dc"] = "@class.outer",
            }
        },

    },
}
