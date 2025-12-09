{
  flake.modules.nvf.default = {
    vim.presence = {
      neocord = {
        enable = true;
        setupOpts = {
          enable_line_number = true;
        };
      };
    };
  };
}
