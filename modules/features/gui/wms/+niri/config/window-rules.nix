{
  flake.modules.nixos.niri = {lib, ...}: let
    radius = 15.0;
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
          match is-floating=false
          tiled-state true
        }

        window-rule {
          match title="RuneLite"
          open-floating true
          opacity 1.0
        }

        window-rule {
          match title="Kando Menu"
          open-floating true
          border {
            off
          }
          shadow {
            off
          }
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
