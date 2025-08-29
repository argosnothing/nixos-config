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
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    hardware.bluetooth.enable = true;
    services.desktopManager.plasma6.enable = true;
    programs.kdeconnect.enable = true;
    styles.stylix.enable = false;
  };
}
