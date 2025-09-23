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
    ./dwm.nix
    ./mango.nix
    ./dwl.nix
    ./qtile.nix
  ];
  options = {
    custom.wm.name = mkOption {
      type = enum ["hyprland" "dwm" "dwl" "gnome" "cosmic" "qtile" "mango"];
      description = "System desktop environment(?)";
    };
  };
  config = {
    custom.wm.name = settings.wm;
  };
}
