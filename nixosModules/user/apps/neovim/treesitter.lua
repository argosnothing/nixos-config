require'nvim-treesitter.configs'.setup {
  auto_install = false,
  
  highlight = {
    enable = true,
  },
  
  indent = {
    enable = true,
  },
  
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
