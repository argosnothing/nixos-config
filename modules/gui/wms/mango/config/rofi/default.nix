{
  pkgs,
  config,
  settings,
  lib,
  ...
}: let
  rofi-config = import ./config.nix {inherit config;};
in {
  config = lib.mkIf config.my.modules.gui.wms.mango.enable {
    hjem.users.${settings.username} = {
      packages = [pkgs.rofi];
    };
    files = {
      ".config/rofi/config.rasi".text = rofi-config;
    };
  };
}
