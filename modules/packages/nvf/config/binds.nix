{
  flake.modules.nvf.default = {
    vim.keymaps = [
      {
        mode = "n";
        key = "<leader>lf";
        action = ":lua vim.lsp.buf.format()<CR>";
        silent = true;
      }
    ];
    vim.binds = {
      whichKey = {
        enable = true;
      };
      cheatsheet.enable = true;
    };
  };
}
