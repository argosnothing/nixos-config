{
  flake.modules.nixos.niri = {lib, ...}: let
    radius = 0.0;
  in {
    my.wm.niri.settings = lib.mkAfter [
      ''
        window-rule {
          geometry-corner-radius ${toString radius}
          opacity 0.99
          clip-to-geometry true
          draw-border-with-background false
        }

        window-rule {
          match app-id="kitty"
          exclude title="^pamix$"
          opacity 0.95
        }

        window-rule {
          match title="RuneLite"
          open-floating true
          opacity 1.0
        }

        window-rule {
          match title="pamix"
          opacity 0.99
          open-floating true
          tiled-state false
        }

        window-rule {
          match app-id="nemo"
          opacity 0.99
          open-floating true
          tiled-state false
        }

        window-rule {
          match app-id="Wfica"
          opacity 0.99
          open-fullscreen false
          open-maximized true
          block-out-from "screen-capture"
        }

      ''
    ];
  };
}
