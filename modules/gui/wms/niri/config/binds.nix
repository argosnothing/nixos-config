{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf;
in {
  config = mkIf niri.enable {
    hm = _: let
      inherit (config.my.modules.gui) desktop-shells;
    in {
      programs.niri.settings.binds = {
        "Mod+Return".action.spawn = "kitty";
        "Mod+space".action.spawn = lib.splitString " " desktop-shells.launcherCommand;
      };
    };
  };
}
