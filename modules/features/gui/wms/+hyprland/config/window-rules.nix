{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      "windowrule = monitor DP-2, match:title ^Smithay$"
      #"windowrule = suppressevent maximize, match:class .*"
      #"windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
}
