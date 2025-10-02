{
  pkgs,
  config,
  settings,
  lib,
  ...
}: {
  options.my.modules.shell.fish = {
    enable = lib.mkEnableOption "FIIIISH";
  };
  config = lib.mkIf config.my.modules.shell.fish.enable {
    programs.fish = {
      enable = true;
    };
  };
}
