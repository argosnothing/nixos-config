{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf;
in {
  config = mkIf niri.enable {
    programs.niri.settings.window-rules = {
      matches = [
      ];
    };
  };
}
