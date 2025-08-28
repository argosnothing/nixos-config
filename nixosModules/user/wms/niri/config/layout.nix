{ ... }:

{
  programs.niri.settings.layout = {
    gaps = 8; # Reduced from 16 to 8 for less spacing
    focus-ring.enable = false; # Disable the ugly border around focused windows
    preset-column-widths = [
      {proportion = 0.33333;}
      {proportion = 0.5;}
      {proportion = 0.66667;}
    ];
  };
}
