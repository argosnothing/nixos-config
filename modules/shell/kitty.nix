{
  pkgs,
  config,
  settings,
  lib,
  ...
}: {
  options.my.modules.shell.kitty = {
    enable = lib.mkEnableOption "Kitty";
  };
  config = lib.mkif config.my.modules.shell.kitty.enable {
    hjem.users.${settings.username} = {
      packages = with pkgs; [
        kitty
      ];
    };
  };
}
