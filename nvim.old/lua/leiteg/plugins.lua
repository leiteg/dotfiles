--------------------------------------------------------------------------------
--                       __            _              __                      --
--                ____  / /_  ______ _(_)___  _____  / /_  ______ _           --
--               / __ \/ / / / / __ `/ / __ \/ ___/ / / / / / __ `/           --
--              / /_/ / / /_/ / /_/ / / / / (__  ) / / /_/ / /_/ /            --
--             / .___/_/\__,_/\__, /_/_/ /_/____(_)_/\__,_/\__,_/             --
--            /_/            /____/                                           --
--                                                                            --
--------------------------------------------------------------------------------

-- Start Packer with plugin configurations
return require('packer').startup(function(use)

    -- USER INTERFACE ----------------------------------------------------- {{{1

    -- Dracula color scheme
    use {
        'dracula/vim',
        as = 'dracula.nvim',
        config = function()
            vim.cmd [[colorscheme dracula]]
        end
    }

    -- Airline statusline
    use {
        'vim-airline/vim-airline',
        config = function()
            vim.g.airline_theme = 'dracula'
            vim.g.airline_powerline_fonts = 1
            vim.g.airline_detect_modified = 1
            vim.g.airline_detect_paste = 1
            vim.g.airline_left_sep = ''
            vim.g.airline_left_alt_sep = ''
            vim.g.airline_right_sep = ''
            vim.g.airline_right_alt_sep = ''
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline#extensions#tabline#fnamemod'] = ':t'
            vim.g['airline#extensions#tabline#tab_min_count'] = 1
            vim.g['airline#extensions#tabline#buffer'] = 1
            vim.g['airline#extensions#tabline#show_tabs'] = 1
            vim.g['airline#extensions#tabline#show_close_button'] = 0
        end,
        requires = {'vim-airline/vim-airline-themes'}
    }

    -- Inline commit information
    use {
        'apzelos/blamer.nvim',
        config = function()
            vim.g.blamer_enabled = 1
            vim.g.blamer_delay = 1500
            vim.g.blamer_show_in_visual_modes = 0
            vim.g.blamer_relative_time = 1
        end
    }

    -- Highlight git conflicts in file
    use { 'rhysd/conflict-marker.vim' }

    -- EDITING ------------------------------------------------------------ {{{1

    -- Surround text with brackets
    use {
        'kylechui/nvim-surround',
        tag = '*',
        config = function()
            require('nvim-surround').setup()
        end
    }

    -- Commenting
    use {
        'numtostr/comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Autoclose brackets
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end,
    }

    -- Align lines by character
    use {
        'junegunn/vim-easy-align',
        config = function()
            local map_ = vim.keymap.set
            map_('n', 'ga', '<Plug>(EasyAlign)', {silent = true})
            map_('x', 'ga', '<Plug>(EasyAlign)', {silent = true})
        end
    }

    use { 'tpope/vim-endwise' }

    -- MOVEMENT ----------------------------------------------------------- {{{1

    -- Fast movement using `s` followed by two characters
    use {
        'justinmk/vim-sneak',
        config = function()
            vim.g['sneak#label'] = 1
        end
    }

    -- FUNCTIONALITY ------------------------------------------------------ {{{1

    -- Packer manages itself
    use {
        'wbthomason/packer.nvim',
        config = function()
            local map_ = vim.keymap.set
            map_('n', '<Leader>ps', '<cmd>PackerSync<CR>', {silent=true})
            map_('n', '<Leader>pc', '<cmd>PackerCompile<CR>', {silent=true})
        end
    }

    -- Sensible defaults
    use { 'tpope/vim-sensible' }

    -- Infer buffer optiosn from contents
    use { 'tpope/vim-sleuth' }

    -- Provides several paired mappings
    use { 'tpope/vim-unimpaired' }

    -- Show diff and status when editing commit message
    use { 'rhysd/committia.vim' }

    -- Git wrapper
    use {
        'tpope/vim-fugitive',
        config = function()
            local map_ = vim.keymap.set
            map_('n', '<Leader><Leader>', '<cmd>Git<CR>',        {silent = true})
            map_('n', '<Leader>gc',       '<cmd>Git commit<CR>', {silent = true})
            map_('n', '<Leader>gr',       '<cmd>Git review<CR>', {silent = true})
            map_('n', '<Leader>ls',       '<cmd>Git log<CR>',    {silent = true})
            map_('n', '<Leader>gd',       '<cmd>Git diff<CR>',   {silent = true})
        end
    }

    -- Fuzzy searcher
    use {
        'junegunn/fzf',
        run = function()
            vim.call('fzf#install')
        end
    }

    -- Fuzzy searcher integration with editor
    use {
        'junegunn/fzf.vim',
        config = function()
            local map_ = vim.keymap.set
            map_('n', '<C-P>',      '<cmd>GFiles<CR>',  {silent = true})
            map_('n', 'g<C-P>',     '<cmd>Files<CR>',   {silent = true})
            map_('n', '<Leader>gg', '<cmd>Commits<CR>', {silent = true})
            map_('n', '<Leader>jk', '<cmd>Buffers<CR>', {silent = true})
            map_('n', '<Leader>gt', '<cmd>Tags<CR>',    {silent = true})
            map_('n', '<Leader>gT', '<cmd>BTags<CR>',   {silent = true})
            vim.env.FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
        end,
        -- Provides commands :RgRaw and :AgRaw
        requires = 'jesseleite/vim-agriculture'
    }

    -- Snippet engine
    use {
        'sirver/ultisnips',
        config = function()
            vim.g.UltiSnipsEditSplit = "vertical"
            vim.g.UltiSnipsSnippetDirectories = {"snips"}
            vim.g.UltiSnipsExpandTrigger = "<c-l>"
            vim.g.UltiSnipsListSnippets = "<c-tab>"
            vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
            vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
        end
    }

    -- Language server protocol
    use {
        'neovim/nvim-lspconfig',
        config = function()
            local on_attach = function(client, bufnr)
                -- Enable completion via <C-X><C-O>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                local map = vim.keymap.set
                local opts = { silent = true, noremap = true, buffer = bufnr }

                -- Mappings (TODO: add more mappings)
                map('n', 'gd',         vim.lsp.buf.definition,              opts)
                map('n', 'gD',         vim.lsp.buf.declaration,             opts)
                map('n', 'gr',         vim.lsp.buf.references,              opts)
                map('n', 'K',          vim.lsp.buf.hover,                   opts)
                map('n', '<Leader>f',  vim.lsp.buf.format,                  opts)
                map('n', '<Leader>q',  vim.lsp.buf.code_action,             opts)
                map('n', '<Leader>rn', vim.lsp.buf.rename,                  opts)
                map('n', '<Leader>e',  vim.diagnostic.open_float,           opts)
                map('n', '<Leader>sh', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
            end

            local lspconfig = require 'lspconfig'
            local opts = { on_attach = on_attach }

            -- Language servers
            lspconfig.rust_analyzer.setup{
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false;
                        }
                    }
                },
                on_attach = on_attach,
            }
            lspconfig.clangd.setup(opts)
            lspconfig.cmake.setup(opts)
            lspconfig.pyright.setup(opts)
        end
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'c', 'cpp', 'python', 'rust', 'lua' },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                }
            }
        end
    }

    -- Treesitter playground
    use {
        'nvim-treesitter/playground',
        config = function()
            require('nvim-treesitter.configs').setup {
                playground = {
                    enable = true,
                }
            }
        end
    }

    -- Completion (TODO: Add more sources)
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            { 
                'quangnguyen30192/cmp-nvim-ultisnips',
                config = function()
                    require'cmp_nvim_ultisnips'.setup{}
                end
            }
        },
        config = function()
            local cmp = require'cmp'
            cmp.setup {
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'ultisnips' },
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({select=true}),
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            }
        end
    }

    -- File browser
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('nvim-tree').setup()
            local map_ = vim.keymap.set
            map_('n', '<Leader>z', '<cmd>NvimTreeToggle<CR>', {silent=true, noremap=true})
        end
    }

    -- Neorg
    -- use {
    --     'nvim-neorg/neorg',
    --     tag = '0.0.12',
    --     config = require('leiteg.config.neorg').config,
    --     requires = {
    --         'nvim-lua/plenary.nvim',
    --         'max397574/neorg-kanban'
    --     }
    -- }

    -- Personal Wiki
    -- use {
    --     'vimwiki/vimwiki',
    --     config = function()
    --         vim.g.vimwiki_dir_link = 'index'
    --         vim.g.vimwiki_hl_cb_checked = 1
    --         vim.g.vimwiki_autowriteall = 1
    --         vim.g.vimwiki_folding = 'expr'
    --         vim.g.vimwiki_list = {
    --             {
    --                 template_path = vim.fn.stdpath("data") .. "site/pack/packer/start/vimwiki/autoload/",
    --                 path = "~/life",
    --                 links_space_char = '-',
    --                 diary_rel_path = 'journal/',
    --                 diary_index = 'index',
    --                 diary_header = "Journal",
    --                 auto_tags = 1,
    --                 auto_diary_index = 1,
    --                 nested_syntaxes = {
    --                     python = 'python',
    --                     ['c++'] = 'cpp',
    --                 }
    --             }
    --         }
    --     end
    -- }

    -- LANGUAGE SPECIFIC -------------------------------------------------- {{{1

    -- Several language packs
    use { 'sheerun/vim-polyglot' }

    -- Rust
    use { 'rust-lang/rust.vim', ft = 'rust' }

    -- HTML
    use { 'mattn/emmet-vim', ft = 'html' }
    use { 'alvan/vim-closetag', ft = 'html' }

    -- Markdown
    use { 'ellisonleao/glow.nvim', ft = 'markdown' }

    -- LaTeX
    use {
        'lervag/vimtex',
        config = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_complete_close_braces = 1
            vim.g.vimtex_compiler_latexmk = {
                callback = 0,
                build_dir = 'build',
            }
            vim.g.vimtex_view_method = 'zathura'
            if vim.fn.has('mac') == 1 then
                vim.g.vimtex_view_method = 'skim'
            end
            vim.g.vimtex_syntax_conceal = {
                accents = 1,
                ligatures = 1,
                cites = 1,
                fancy = 1,
                greek = 1,
                math_bounds = 1,
                math_delimiters = 1,
                math_fracs = 1,
                math_super_sub = 1,
                math_symbols = 1,
                sections = 1,
                styles = 1,
            }
        end
    }

    -- OPTIONAL ----------------------------------------------------------- {{{1

    -- Interactive git history
    use { 'junegunn/gv.vim', cmd = 'GV' }

    -- Distraction free editing
    use { 'junegunn/goyo.vim', cmd = 'Goyo' }

    -- Better writing
    use {
        'preservim/vim-pencil',
        cmd = { 'Pencil', 'PencilToggle', 'PencilSoft', 'PencilHard' },
        config = function()
            vim.g['pencil#autoformat'] = 1
            vim.g['pencil#wrapModeDefault'] = 'hard'
            vim.g['pencil#textwidth'] = 80
        end
    }

    -- TODO --------------------------------------------------------------- {{{1

    -- use { 'nvim-lua/completion-nvim' }
    -- use { 'nvim-telescope/telescope.nvim' }
    -- use { 'numtostr/navigator.nvim' }
    -- use { 'rcarriga/nvim-notify' }
    -- use { 'gelguy/wilder.nvim' }

    -- DISABLED ----------------------------------------------------------- {{{1

    -- use { 'tpope/vim-commentary' }
    -- use { 'tpope/vim-git' }
    -- use { 'tpope/vim-markdown' }
    -- use { 'tpope/vim-repeat' }
    -- use { 'tpope/vim-rhubarb' }
    -- use { 'lervag/wiki.vim' }
    -- use { 'neoclide/coc.vim' }
    -- use { 'pineapplegiant/spaceduck' }

    -- use { 'google/yapf' }
    -- use { 'mateusbraga/vim-spell-pt-br' }
    -- use { 'vimjas/vim-python-pep8-indent' }
    -- use { 'wellle/targets.vim' }

    -- }}}

end)
-- vim: foldlevel=99
