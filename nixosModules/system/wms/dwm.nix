{
  pkgs,
  lib,
  config,
  settings,
  ...
}: {
  options = {
    wms.dwm.enable = lib.mkEnableOption "Enable System DWM Session";
  };

  config = lib.mkIf (config.custom.wm.name == "dwm") {
    wms.dwm.enable = true;
    shoulderror.true = true;
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    services = {
      displayManager.ly.enable = true;
      xserver.windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = ./sources/dwm;
        };
      };
      xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
      };
    };
    custom.persist.home.directories = [
      ".config/dwm"
    ];
  };
}
