require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
