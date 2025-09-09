{
  vim.languages = {
    css.enable = true;
    html.enable = true;
    sql.enable = true;

    python = {
      enable = true;
      dap.enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    rust = {
      enable = true;
      crates.enable = true;
    };
  };
}
