{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.qtile.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Qtile as the window manager";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "qtile") {
    wms.qtile.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    styles.stylix.enable = true;
    displayManager.ly.enable = true;
    services = {
      xserver.enable = true;
      xserver.windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages:
          with python3Packages; [
            qtile-extras
          ];
      };
    };
  };
}
