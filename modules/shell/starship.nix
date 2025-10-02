{
  pkgs,
  lib,
  config,
  settings,
  ...
}: {
  options.my.modules.shell.starship = {
    enable = lib.mkEnableOption "Starship is fun!";
  };
  config = lib.mkIf config.my.modules.shell.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}
