{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.xfce = {
    imports = with flake.modules.nixos; [
    ];
    my.cursor.enable = false;
    services = {
      xserver = {
        enable = true;
        desktopManager = {
          xfce.enable = true;
        };
      };
    };
    my.persist.home.directories = [
      ".config/xfce4"
    ];
  };
}
