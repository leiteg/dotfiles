require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true, },
    indent = { enable = true, },

    textobjects = {

        -- Selection of new text objects (i.e. function, class)
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["a="] = "@assignment.outer",
                ["i="] = "@assignment.inner",
                ["l="] = "@assignment.lhs",
                ["r="] = "@assignment.rhs",
                ["aa"] = "@parameter.inner",
                ["ia"] = "@parameter.inner",
                ["am"] = "@call.outer",
                ["im"] = "@call.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },

        -- Swap AST nodes.
        swap = {
            enable = true,
            swap_next = {
                ["<leader>pj"] = "@parameter.inner",
                ["<leader>fj"] = "@function.outer",
                ["<leader>cj"] = "@class.outer",
            },
            swap_previous = {
                ["<leader>pk"] = "@parameter.inner",
                ["<leader>fk"] = "@function.outer",
                ["<leader>ck"] = "@class.outer",
            },
        },

        -- Move around file.
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[A"] = "@parameter.inner",
            },
        },

        -- Shows a floating window with preview.
        lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
                ["<leader>pf"] = "@function.outer",
                ["<leader>pc"] = "@class.outer",
            }
        },

    },
}
