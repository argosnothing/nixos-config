{lib, ...}: let
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
      ./niri
      ./mango
      ./oxwm
      ./xfce
      ./lxqt
    ];
  options = {
    my.modules.gui.wms.name = mkOption {
      type = enum ["niri" "cosmic" "oxwm" "mango" "xfce" "lxqt"];
      description = "Winder Manager/Desktop Environment Choice";
    };
  };
}
