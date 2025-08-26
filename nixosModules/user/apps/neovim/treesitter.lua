require'nvim-treesitter.configs'.setup {
  -- Syntax highlighting
  highlight = {
    enable = true,
  },
  
  -- Automatic indentation
  indent = {
    enable = true,
  },
  
  -- Incremental selection
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
