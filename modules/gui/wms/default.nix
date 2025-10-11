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
      ./niri
      ./mango
    ];
  options = {
    my.modules.gui.wms.name = mkOption {
      type = enum ["niri" "cosmic" "mango"];
      description = "Winder Manager/Desktop Environment Choice";
    };
  };
  config = {
    my.modules.gui.wms.name = settings.wm;
  };
}
