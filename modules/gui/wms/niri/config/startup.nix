{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.lists) optionals;
  inherit (config.my.modules.gui.wms) niri;
  inherit (config.my.modules.gui) desktop-shells;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.spawn-at-startup = optionals (desktop-shells.name
        != "dank-shell") [
        {argv = ["${desktop-shells.execCommand}"];}
      ];
    };
  };
}
