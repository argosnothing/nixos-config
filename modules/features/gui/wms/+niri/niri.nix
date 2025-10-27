{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: let
    nixos-modules = with config.flake.modules.nixos; [
      wm
      cursor
      icons
      gtk
      stylix
      noctalia-shell
    ];
    home-modules = [
      {
        hm.imports = [config.flake.modules.homeManager.niri];
      }
    ];
  in {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    imports =
      [inputs.niri.nixosModules.niri]
      ++ nixos-modules
      ++ home-modules;
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
  flake.modules.homeManager.niri = {pkgs, ...}: {
    programs = {
      niri = {
        package = pkgs.niri-unstable;
      };
    };
  };
}
