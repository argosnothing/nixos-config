{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.xfce = {pkgs, ...}: {
    my.cursor.enable = false;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
    environment.systemPackages = with pkgs; [
      chicago95
      ocs-url
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-docklike-plugin
      xorg.xinit
      xdotool
      wmctrl
    ];
    services = {
      picom.enable = true;
      displayManager.defaultSession = "xfce";
      xserver.displayManager.lightdm.enable = true;
      xserver = {
        enable = true;
        desktopManager = {
          xterm.enable = false;
          xfce = {
            enable = true;
          };
        };
      };
    };
  };
}
