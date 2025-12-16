# Stuff I generally want to have on my desktop.
{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.gui-apps = {pkgs, ...}: let
    nixos-modules = with flake.modules.nixos; [
      discord
      firefox
      steam
      nemo
      audacity
      spotify-player
      spicetify
      gajim
      obsidian
    ];
  in {
    imports = nixos-modules;
  };
}
