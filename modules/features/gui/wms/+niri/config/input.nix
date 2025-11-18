{
  flake.modules.homeManager.disabled = {
    programs.niri.settings.input = {
      focus-follows-mouse.enable = false;
      warp-mouse-to-focus.enable = false;
      mod-key = "Super";
      mod-key-nested = "Super";
      mouse = {
        accel-speed = 0.3;
        accel-profile = "flat";
      };
      touchpad = {
        dwt = true;
        scroll-factor = 0.5;
      };
    };
  };
}
