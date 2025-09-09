{ ... }:

{
  programs.niri.settings.input = {
    focus-follows-mouse.enable = true;
    mod-key = "Alt";
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
