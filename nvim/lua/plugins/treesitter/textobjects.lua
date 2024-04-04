return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
        require("nvim-treesitter.configs").setup {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["a="] = "@assignment.outer",
                        ["i="] = "@assignment.inner",
                        ["l="] = "@assignment.lhs",
                        ["r="] = "@assignment.rhs",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["am"] = "@call.outer",
                        ["im"] = "@call.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>aj"] = "@parameter.inner",
                        ["<leader>fj"] = "@function.outer",
                        ["<leader>cj"] = "@class.outer",
                    },
                    swap_previous = {
                        ["<leader>ak"] = "@parameter.inner",
                        ["<leader>fk"] = "@function.outer",
                        ["<leader>ck"] = "@class.outer",
                    },
                },
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
                lsp_interop = {
                    enable = true,
                    border = 'none',
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ["<leader>fp"] = "@function.outer",
                        ["<leader>cp"] = "@class.outer",
                    }
                },
            },
        }
    end,
}
