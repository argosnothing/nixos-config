{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
  ];
  options = {
    wms.niri.enable = pkgs.lib.mkOption {
      type = pkgs.lib.types.bool;
      default = false;
      description = "Enable Niri as the window manager.";
    };
  };
  config = lib.mkIf config.wms.niri.enable {
    # Enable the niri program through the flake's NixOS module
    programs.niri.enable = true;

    greeters.tuigreet.wm = "niri-session";
    greeters.tuigreet.enable = true;
    services.xserver.excludePackages = [pkgs.xterm];

    # Enable Wayland requirements
    programs.xwayland.enable = true;

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
