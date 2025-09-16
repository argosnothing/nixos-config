{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./dconf.nix
  ];
  options = {
    wms.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable GNOME desktop environment.";
    };
  };
  config = lib.mkIf config.wms.gnome.enable {
    home.packages = with pkgs; [
      gtop
      adwaita-icon-theme
      dconf2nix
      gnome-tweaks
      gnome-pomodoro
      gnomeExtensions.vertical-workspaces
      gnomeExtensions.ddterm
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.vitals
      gnomeExtensions.advanced-alttab-window-switcher
      gnomeExtensions.alt-tab-current-monitor
      gnomeExtensions.dash-to-panel
      gnomeExtensions.dash-in-panel
      gnomeExtensions.wintile-windows-10-window-tiling-for-gnome
      gnomeExtensions.unmess
      gnomeExtensions.gsconnect
      gnomeExtensions.user-themes
    ];
    styles.stylix.enable = false;
    dconf.settings = {
      "org/gnome/mutter" = {
        "experimental-features" = ["scale-monitor-framebuffer"];
      };
      "org/gnome/desktop/interface" = {
        "cursor-theme" = "Adwaita";
        "icon-theme" = "Adwaita";
      };
      "org/gnome/shell/app-switcher" = {
        "current-workspace-only" = true;
      };
      "org/gnome/mutter/wayland" = {
        "xwayland-grab-access-rules" = ["Wfica"];
        "xwayland-allow-grabs" = true;
      };
    };
    custom.persist.home.directories = [
      ".config/gnome-shell"
      ".local/share/applications"
    ];
  };
}
