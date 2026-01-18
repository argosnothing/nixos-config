# Stuff I generally want to have on for my shells
{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.shell-apps = {pkgs, ...}: let
    nixos-modules = with flake.modules.nixos; [
      copilot-cli
      yazi
      helix
      kitty
      fish
      nh
      git
      misc-scripts
      starship
      fetch
      build-iso
    ];
  in {
    imports = nixos-modules;
  };
}
