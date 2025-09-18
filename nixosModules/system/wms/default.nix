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
    #./niri.nix bleh
    ./gnome.nix
  ];
  options = {
    custom.wm.name = mkOption {
      type = enum ["hyprland" "dwm" "gnome" "cosmic"];
      description = "System desktop environment(?)";
    };
  };
  config = {
    custom.wm.name = settings.wm;
  };
}
