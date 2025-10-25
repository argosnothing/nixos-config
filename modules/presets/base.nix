# This is a base preset, that defines the things i need to have for a functional nixos system.
# Not counting for wms
{config, ...}: {
  flake.modules.nixos.base = let
    nixos-modules = with config.flake.modules.nixos; [
      user
      fonts
      critical
      home
    ];
    home-modules = with config.flake.homeModules; [
    ];
    in{
    imports = nixos-modules ++ home-modules;
  };
}
