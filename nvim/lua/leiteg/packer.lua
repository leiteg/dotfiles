vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Package manager itself.
    use {'wbthomason/packer.nvim' }
    -- Miscellaneous functions (required by Telescope)
    use { 'nvim-lua/plenary.nvim' }
    -- Colorscheme
    use { 'dracula/vim', as = "dracula.nvim" }
    -- Git integragtion
    use { 'tpope/vim-fugitive' }
    -- Additional bracket mappings
    use { 'tpope/vim-unimpaired' }
    -- Undo on steroids
    use { 'mbbill/undotree' }
    -- Surround text with symbols
    use { 'kylechui/nvim-surround' }
    -- Move around screen
    use {
        'justinmk/vim-sneak',
         config = function()
             vim.g["sneak#label"] = 1
         end
     }
    -- Align text
    use { 'junegunn/vim-easy-align' }
    -- Snippets
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
    -- Rust IDE
    use { 'rust-lang/rust.vim', ft = 'rust' }
    -- LaTeX IDE
    use { 'lervag/vimtex' }
    -- Python sane indent
    use { 'Vimjas/vim-python-pep8-indent' }
    -- Commenting stuff
    use { 'numToStr/Comment.nvim' }
    -- File explorer
    use { 'stevearc/oil.nvim' }
    -- Take code screenshots
    use { 'krivahtoo/silicon.nvim', run = './install.sh' }

    -- Language server protocol
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        }
    }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    use { 'nvim-treesitter/playground' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    -- Telescope
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Completion
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'quangnguyen30192/cmp-nvim-ultisnips' }
end)
