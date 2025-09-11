{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
in {
  options = {
    wms.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland as the window manager.";
    };
  };
  config = lib.mkIf config.wms.hyprland.enable {
    greeters.tuigreet.wm = "Hyprland";
    greeters.tuigreet.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.xserver.excludePackages = [pkgs.xterm];

    # Ensure GTK cache is built
    programs.dconf.enable = true;
    services.dbus.enable = true;
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
    services.gnome.gnome-keyring.enable = true;
  };
}
