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
  config = lib.mkIf (config.custom.wm.name == "niri") {
    wms.niri.enable = true;
    programs = {
      niri.enable = true;
      xwayland.enable = true;
      dconf.enable = true;
    };

    greeters.tuigreet.wm = "niri-session";
    greeters.tuigreet.enable = true;
    services = {
      xserver.excludePackages = [pkgs.xterm];
      dbus = {
        enable = true;
        packages = with pkgs; [
          gcr
          gnome-settings-daemon
          libsecret
        ];
      };
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
    };

    qt.enable = true;

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
      inputs.swww.packages.${pkgs.system}.swww # Desktop wallpaper manager
      # Qt packages for QuickShell
      qt6.full
      qt6.qttools # includes qmlls language server
      # Additional GNOME components for GUI functionality
      gcr
      libsecret
    ];

    security.pam.services.login.enableGnomeKeyring = true;
  };
}
