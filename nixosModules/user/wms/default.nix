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
    ./hyprland
    #./niri
    ./gnome
  ];
  options = {
    custom.wm.name = mkOption {
      type = enum ["hyprland" "niri" "gnome" "cosmic"];
      description = "User desktop environment";
    };
  };
  config = {
    custom.wm.name = settings.wm;
  };
}
