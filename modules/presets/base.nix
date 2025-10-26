# This is a base preset, that defines the things i need to have for a functional nixos system.
# Not counting for wms
{config, ...}: {
  flake.settings = {
    username = "salivala";
  };
  flake.modules.nixos.base = {pkgs, ...}: let
    nixos-modules = with config.flake.modules.nixos; [
      options
      user
      critical
      home

      kitty
      fish
      nh
      misc-scripts
    ];
    home-modules = [
      {
        hm.imports = with config.flake.modules.homeManager; [
          options
        ];
        hm.home.packages = with config.flake.packages.${pkgs.system}; [
          nvf
          zeditor
        ];
      }
    ];
  in {
    imports = nixos-modules ++ home-modules;
  };
}
