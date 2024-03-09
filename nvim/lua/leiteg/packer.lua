vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    use { 'wbthomason/packer.nvim' }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 'dracula/vim', as = "dracula.nvim" }

    use { 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}
    use { 'nvim-treesitter/playground' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-unimpaired' }
    use { 'mbbill/undotree' }
    use {
        'kylechui/nvim-surround',
        tag = '*',
        config = function()
            require('nvim-surround').setup()
        end
    }
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
      }
    }
    use {
        'justinmk/vim-sneak',
        config = function()
            vim.g['sneak#label'] = 1
        end
    }
    use { 'junegunn/vim-easy-align' }
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
    use { 'rust-lang/rust.vim', ft = 'rust' }
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
    use { 'https://github.com/Vimjas/vim-python-pep8-indent' }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

end)
