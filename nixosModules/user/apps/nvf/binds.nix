{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.enable {
    programs.nvf.settings.vim.binds = {
      whichKey = {
        enable = true;
        register = {
          "test" = "test";
        };
      };
      cheatsheet.enable = true;
    };
  };
}
