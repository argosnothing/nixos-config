{
  pkgs,
  lib,
  config,
  settings,
  ...
}: {
  options = {
    wms.dwm.enable = lib.mkEnableOption "Enable User Dwm";
  };

  # in case there is something i want to do at the hm level that is specific to dwm.
  config =
    lib.mkIf (config.custom.wm.name == "dwm") {
    };
}
