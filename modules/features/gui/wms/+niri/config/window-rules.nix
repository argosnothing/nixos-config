{
  flake.modules.nixos.niri = {lib, ...}: let
    radius = 8.0;
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
          opacity 1.0
        }

        window-rule {
          match app-id="kitty_floating"
          opacity 0.8
          open-floating true
          baba-is-float true
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
          opacity 1.00
          open-fullscreen false
          open-maximized true
          block-out-from "screen-capture"
        }

        window-rule {
          match app-id="Emacs"
          opacity 1.00
          open-fullscreen false
          open-maximized true
        }

      ''
    ];
  };
}
