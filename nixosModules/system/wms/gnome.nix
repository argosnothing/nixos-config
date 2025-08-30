{
  pkgs,
  pkgsUnstable,
  lib,
  config,
  ...
}: {
  options = {
    wms.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNOME as the window manager.";
    };
  };
  config = lib.mkIf config.wms.gnome.enable {

    environment.systemPackages = with pkgs; [
      gnomeExtensions.task-up-ultralite
    ];
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    styles.stylix.enable = false;
  };
}
