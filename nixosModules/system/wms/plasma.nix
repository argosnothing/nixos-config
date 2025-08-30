{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    wms.plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Plasma user configuration.";
    };
  };

  config = lib.mkIf config.wms.plasma.enable {
    services.xserver.enable = true; # optional
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        Wayland = {
          # Force SDDM to use only primary display to avoid multi-monitor NVIDIA issues
          #CompositorCommand = "kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1";
        };
      };
    };
    hardware.bluetooth.enable = true;
    services.desktopManager.plasma6.enable = true;
    programs.kdeconnect.enable = true;
    styles.stylix.enable = false;
  };
}
