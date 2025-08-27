{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.niri.enable = pkgs.lib.mkOption {
      type = pkgs.lib.types.bool;
      default = false;
      description = "Enable Niri as the window manager.";
    };
  };
  config = lib.mkIf config.wms.niri.enable {
    greeters.tuigreet.enable = true;
    programs.niri = {
      enable = true;
      wayland = true;
      xwayland = true;
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
