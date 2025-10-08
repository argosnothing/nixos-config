{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf mkForce;
  c = config.lib.stylix.colors.withHashtag;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.layout = {
        focus-ring = mkForce {
          active = c.base0E;
        };
      };
    };
  };
}
