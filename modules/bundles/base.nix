# This is a base preset, that defines the things i need to have for a functional nixos system.
# Not counting for wms
{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.base = {pkgs, ...}: let
    nixos-modules = with flake.modules.nixos; [
      options
      networking
      sops
      keyd
      user
      critical
      home
      gnome-keyring
      misc
      packages
    ];
  in {
    imports = nixos-modules;
    config.my.username = "salivala";
  };
}
