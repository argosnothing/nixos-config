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
      xorg.xinit
    ];
    services = {
      displayManager = {
        gdm.enable = true;
        defaultSession = "xfce";
      };
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
    my.persist.home.directories = [
      ".config/xfce4"
    ];
  };
}
