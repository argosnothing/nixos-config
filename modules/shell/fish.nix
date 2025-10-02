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
    hjem.users.${settings.username}.rum.programs.fish = {
      enable = true;
    };
    programs.fish = {
      enable = true;
    };
  };
}
