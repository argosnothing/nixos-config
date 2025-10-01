{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.nvf.enable {
    programs.nvf.settings.vim.binds = {
      whichKey = {
        enable = true;
      };
      cheatsheet.enable = true;
    };
  };
}
