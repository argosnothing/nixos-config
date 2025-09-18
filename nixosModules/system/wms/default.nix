{
  settings,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum;
in {
  imports = [
    ./cosmic.nix
    ./gnome.nix
    ./hyprland.nix
    ./niri.nix
    ./gnome.nix
  ];
  options = {
    custom.wm.name = mkOption {
      type = enum ["hyprland" "niri" "gnome" "cosmi"];
      description = "System desktop environment(?)";
    };
  };
  config = {
    custom.wm.name = settings.wm;
  };
}
