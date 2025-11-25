{
  flake.modules.nvf.default = {
    vim.formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        formatters_by_ft = {
          nix = ["alejandra"];
        };
      };
    };
  };
}
