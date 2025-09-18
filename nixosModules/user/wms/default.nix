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
    #./niri can't be arsed figuring this one out rn.
    ./gnome
  ];
  options = {
    custom.wm.name = mkOption {
      type = enum ["hyprland" "gnome" "cosmic"];
      description = "User desktop environment";
    };
  };
  config = {
    custom.wm.name = settings.wm;
  };
}
