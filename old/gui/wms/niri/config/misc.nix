{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my.modules.gui.wms) niri;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings = {
        prefer-no-csd = true;
      };
    };
  };
}
