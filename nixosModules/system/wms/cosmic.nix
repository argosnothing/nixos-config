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
    # Enable COSMIC desktop manager (now built into nixpkgs 25.05)
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # Enable Flatpak for COSMIC Store
    services.flatpak.enable = true;

    # Optional: Enable clipboard manager support
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";

    # Basic desktop portal support
    services.dbus.enable = true;
    programs.dconf.enable = true;

    # Essential packages for COSMIC
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      hicolor-icon-theme
      glib
      gsettings-desktop-schemas
    ];
  };
}
