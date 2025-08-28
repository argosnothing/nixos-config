{ ... }:

{
  programs.niri.settings.input = {
    keyboard.xkb.layout = "us";
    touchpad = {
      tap = true;
      natural-scroll = true;
    };
    mouse = {
      "accel-profile" = "flat";
    };
  };
}
