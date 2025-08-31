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
      adwaita-icon-theme
      dconf2nix
      guake
      gnome-tweaks
      gnomeExtensions.advanced-alttab-window-switcher
      gnomeExtensions.alt-tab-current-monitor
      gnomeExtensions.dash-to-panel
      gnomeExtensions.dash-in-panel
      gnomeExtensions.unmess
      gnomeExtensions.gsconnect
      gnomeExtensions.gsnap
      gnomeExtensions.task-up-ultralite
      gnomeExtensions.user-themes
    ];
    styles.stylix.enable = false;
    dconf.settings = {
      "org/gnome/mutter" = {
        "experimental-features" = [ "scale-monitor-framebuffer" ];
      };
      "org/gnome/desktop/interface" = {
        "cursor-theme" = "Adwaita";
        "icon-theme" = "Adwaita";
      };
      "org/gnome/shell/app-switcher" = {
        "current-workspace-only" = true;
      };
      "org/gnome/mutter/wayland" = {
        "xwayland-grab-access-rules" = [ "Wfica" ];
        "xwayland-allow-grabs" = true;
      };
    };
  };
}
