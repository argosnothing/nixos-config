{config, ...}: {
  flake.modules.nixos.niri = {
    inputs,
    pkgs,
    ...
  }: let
    nixos-modules = with config.flake.modules.nixos.niri; [];
    home-modules = [
      {
        hm.imports = config.flake.modules.homeManager.niri;
      }
    ];
  in {
    imports =
      [inputs.niri.nixosModules.niri]
      ++ nixos-modules
      ++ home-modules;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = "gtk gnome";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
          "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        };
        niri.default = [
          "gtk"
          "gnome"
          "wlr"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];
    };
    programs.niri = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}
