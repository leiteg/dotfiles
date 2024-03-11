vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Package manager itself.
    use { 'wbthomason/packer.nvim' }
    -- Miscellaneous functions (required by Telescope)
    use { 'nvim-lua/plenary.nvim' }
    -- Fuzzy finder
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }
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
    use { 'justinmk/vim-sneak' }
    -- Align text
    use { 'junegunn/vim-easy-align' }
    -- Snippets
    use { 'sirver/ultisnips' }
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

    -- Language server protocol
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-buffer'},
        {'quangnguyen30192/cmp-nvim-ultisnips'},
        {'L3MON4D3/LuaSnip'},
      }
    }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}
    use { 'nvim-treesitter/playground' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

end)
