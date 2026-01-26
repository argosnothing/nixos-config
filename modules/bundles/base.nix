# This is a base preset, that defines the things i need to have for a functional nixos system.
# Not counting for wms
{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.base = {pkgs, ...}: let
    username = "salivala";
    nixos-modules = with flake.modules.nixos; [
      options
      networking
      sops
      keyd
      user
      home
      gnome-keyring
      nix-settings
      misc
      shell-apps
      packages
    ];
  in {
    imports = nixos-modules;
    config.quantum = {
      quantum-dir = "/home/${username}/nixos-config/.quantum";
      inherit username;
    };
    config.my.username = username;
  };
}
