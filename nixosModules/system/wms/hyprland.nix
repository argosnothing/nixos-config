{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland as the window manager.";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "hyprland") {
    wms.hyprland.enable = true;
    styles.stylix.enable = true;
    greeters.tuigreet.wm = "Hyprland";
    greeters.tuigreet.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    services = {
      udisks2.enable = true;
      gvfs.enable = true;

      xserver.excludePackages = [pkgs.xterm];
      dbus.enable = true;
      gnome.gnome-keyring.enable = true;
    };

    # Ensure GTK cache is built
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      papirus-icon-theme
      hicolor-icon-theme
      gtk3
      gtk4
      glib
      gsettings-desktop-schemas
      font-awesome
      material-design-icons
    ];

    security.pam.services.login.enableGnomeKeyring = true;
  };
}
