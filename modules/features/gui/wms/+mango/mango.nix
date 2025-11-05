{
  inputs,
  config,
  ...
}: {
  flake.modules.nixos.mango = {pkgs, ...}: let
    nixos-modules = with config.flake.modules.nixos; [
      wm
      dms-greeter
      dms
      cursor
      icons
      gtk
      stylix
    ];
  in {
    imports =
      [
        inputs.mango.nixosModules.mango
      ]
      ++ nixos-modules;
    programs.mango.enable = true;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = ["gtk"];
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];
    };
    environment.systemPackages = [
      pkgs.glib
      pkgs.xdg-utils
      pkgs.wf-recorder
      pkgs.xwayland-satellite
    ];
  };
}
