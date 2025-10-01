{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.programs.nvf.enable {
    programs.nvf.settings.vim.utility = {
      direnv.enable = true;
      mkdir.enable = true;
      nix-develop.enable = true;
      oil-nvim.enable = true;
      sleuth.enable = true;
    };
  };
}
