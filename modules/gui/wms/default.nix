{
  settings,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum;
in {
  imports =
    [
      ./greeters
      ./cursor.nix
    ]
    ++ [
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
    my.modules.gui.wms.name = mkOption {
      type = enum ["hyprland" "dwm" "dwl" "gnome" "cosmic" "qtile" "mango"];
      description = "System desktop environment(?)";
    };
  };
  config = {
    my.modules.gui.wms.name = settings.wm;
  };
}
