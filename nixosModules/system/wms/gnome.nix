{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable GNOME as the window manager.";
    };
  };
  config = lib.mkIf config.wms.gnome.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
