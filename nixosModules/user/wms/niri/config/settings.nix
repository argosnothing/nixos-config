{ ... }:

{
  programs.niri.settings = {
    environment."NIXOS_OZONE_WL" = "1";
    environment."DISPLAY" = ":0";

    spawn-at-startup = [
      {command = ["xwayland-satellite"];}
      {command = ["swww-daemon"];}
    ];

    input = {
      keyboard.xkb.layout = "us";
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
      mouse = {
        "accel-profile" = "flat";
      };
    };

    # Layout configuration
    layout = {
      gaps = 8; # Reduced from 16 to 8 for less spacing
      focus-ring.enable = false; # Disable the ugly border around focused windows
      preset-column-widths = [
        {proportion = 0.33333;}
        {proportion = 0.5;}
        {proportion = 0.66667;}
      ];
    };
  };
}
