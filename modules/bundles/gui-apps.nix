# Stuff I generally want to have on my desktop.
{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.gui-apps = {pkgs, ...}: let
    nixos-modules = with flake.modules.nixos; [
      stylix
      discord
      kitty
      firefox
      steam
      nemo
      audacity
      flatpak
      spotify-player
      spicetify
    ];
  in {
    imports = nixos-modules;
  };
}
