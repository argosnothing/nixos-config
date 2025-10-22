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
      programs.niri.settings.layer-rules = [
        {
          matches = [
            {
              namespace = "^quickshell-wallpaper$";
            }
          ];
          place-within-backdrop = true;
        }
        {
          matches = [
            {
              namespace = "^quickshell-overview$";
            }
          ];
          opacity = 0.0;
        }
      ];
    };
  };
}
