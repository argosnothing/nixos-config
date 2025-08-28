{ ... }:

{
  programs.niri.settings = {
    # Noctalia recommended window rules
    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }
    ];

    # Noctalia recommended layer rules for proper SWWW and shell integration
    layer-rules = [
      {
        matches = [{ namespace = "^swww-daemon$"; }];
        place-within-backdrop = true;
      }
      {
        matches = [{ namespace = "^quickshell-wallpaper$"; }];
      }
      {
        matches = [{ namespace = "^quickshell-overview$"; }];
        place-within-backdrop = true;
      }
    ];
  };
}