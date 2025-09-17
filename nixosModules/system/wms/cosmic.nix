{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.cosmic.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable COSMIC desktop environment.";
    };
  };

  config = lib.mkIf config.wms.cosmic.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      flatpak.enable = true;
      dbus.enable = true;
    };
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      hicolor-icon-theme
      glib
      gsettings-desktop-schemas
    ];
  };
}
