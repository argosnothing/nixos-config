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
              namespace = "^wallpaper$";
            }
          ];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
