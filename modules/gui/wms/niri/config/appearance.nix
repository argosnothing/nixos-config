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
    hm = _: let
      strut-size = 0;
      border-size = 1;
    in {
      programs.niri.settings.layout = {
        gaps = 0;
        struts = {
          left = strut-size;
          right = strut-size;
          top = strut-size;
          bottom = strut-size;
        };
        focus-ring = {
          enable = false;
          active = mkIf custom.enable (mkForce {
            color = c.base0E;
          });
        };
        border = {
          enable = true;
          width = border-size;
          active = mkIf custom.enable (mkForce {
            color = c.base0E;
          });
        };
      };
    };
  };
}
