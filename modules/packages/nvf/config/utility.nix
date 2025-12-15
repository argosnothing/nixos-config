{
  flake.modules.nvf.default = {
    vim.utility = {
      direnv.enable = true;
      mkdir.enable = true;
      nix-develop.enable = true;
      oil-nvim.enable = true;
      sleuth.enable = true;
      snacks-nvim = {
        enable = true;
        setupOpts = {
          dashboard.enable = true;
        };
      };
    };
    vim.assistant.copilot = {
      enable = true;
      cmp.enable = true;
    };
  };
}
