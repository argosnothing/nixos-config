{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: let
    nixos-modules = with config.flake.modules.nixos; [
      wm
      wm.noctalia-shell
    ];
    home-modules = [
      {
        hm.imports = [config.flake.modules.homeManager.niri];
      }
    ];
  in {
    imports =
      [inputs.niri.nixosModules.niri]
      ++ nixos-modules
      ++ home-modules;
    programs.niri = {
      enable = true;
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
