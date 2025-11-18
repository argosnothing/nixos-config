{
  flake.modules.nixos.niri = {lib, ...}: let
    radius = 15.0;
  in {
    my.wm.niri.settings = lib.mkAfter [
      ''
        window-rule {
          geometry-corner-radius ${toString radius}
          opacity 0.99
          clip-to-geometry
          draw-border-with-background off
        }
        
        window-rule {
          match is-floating=false
          tiled-state
        }
        
        window-rule {
          match title="RuneLite"
          open-floating
          opacity 1.0
        }
        
        window-rule {
          match title="Kando Menu"
          open-floating
          border off
          shadow off
        }
        
        window-rule {
          match app-id="Wfica"
          opacity 0.99
          open-fullscreen off
          open-maximized
          block-out-from "screen-capture"
        }
      ''
    ];
  };
}
