{
  settings,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum;
in {
  imports = [
    ./cosmic
    #./gnome
    #./hyprland
    #./niri.nix bleh
    #./gnome
    #./dwm
    ./mango
    #./dwl
    #./qtile
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
