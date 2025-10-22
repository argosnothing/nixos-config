{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (config.my.modules.style.theme) custom;
  inherit (lib) mkIf mkForce;
  c = config.lib.stylix.colors.withHashtag;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.layout = {
        gaps = 9;
        focus-ring = {
          active = mkIf custom.enable (mkForce {
            color = c.base0E;
          });
        };
        border = {
          active = mkIf custom.enable (mkForce {
            color = c.base0E;
          });
        };
      };
    };
  };
}
