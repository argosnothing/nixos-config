{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.window-rules = [
        {
          matches = [
            {
              is-floating = false;
            }
          ];
          tiled-state = true;
        }
      ];
    };
  };
}
