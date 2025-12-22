{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.xfce = {pkgs, ...}: {
    imports = with flake.modules.nixos; [
    ];
    my.cursor.enable = false;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
    environment.systemPackages = with pkgs; [
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-docklike-plugin
    ];
    services = {
      xserver = {
        enable = true;
        displayManager = {
          gdm.enable = true;
          defaultSession = "xfce";
        };
        desktopManager = {
          xfce = {
            enable = true;
          };
        };
      };
    };
    my.persist.home.directories = [
      ".config/xfce4"
    ];
  };
}
