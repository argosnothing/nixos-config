{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf mkForce;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.animations = {
      };
    };
  };
}
