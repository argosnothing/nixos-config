# This is a base preset, that defines the things i need to have for a functional nixos system.
# Not counting for wms
{config, ...}: let
  inherit (config) flake;
in {
  flake.settings = {
    username = "salivala";
  };
  flake.modules.nixos.base = {pkgs, ...}: let
    nixos-modules = with flake.modules.nixos; [
      options
      user
      critical
      home

      discord
      kitty
      fish
      nh
      misc-scripts
      starship
      git
    ];
    home-modules = [
      {
        hm.imports = with flake.modules.homeManager; [
          options
        ];
        hm.home.packages = with flake.packages.${pkgs.system}; [
          nvf
          #zeditor
        ];
      }
    ];
  in {
    imports = nixos-modules ++ home-modules;
  };
}
