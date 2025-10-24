{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf;
in {
  config = mkIf niri.enable {
    hm = _: let
      radius = 0.0;
    in {
      programs.niri.settings.window-rules = [
        {
          matches = [];
          geometry-corner-radius = {
            top-left = radius;
            top-right = radius;
            bottom-left = radius;
            bottom-right = radius;
          };
          opacity = 0.95;
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
        {
          matches = [
            {
              is-floating = false;
            }
          ];
          tiled-state = true;
        }
        {
          matches = [
            {
              title = "Kando Menu";
            }
          ];
          open-floating = true;
          border = {
            enable = false;
          };
          shadow = {
            enable = false;
          };
        }
        {
          matches = [
            {
              app-id = "Wfica";
            }
          ];
          open-fullscreen = false;
          open-maximized = true;
          block-out-from = "screen-capture";
        }
        {
          matches = [
            {
              app-id = "kitty";
            }
          ];
          opacity = 0.95;
        }
      ];
    };
  };
}
