{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        workspace = w[tv1]s[false], gapsout:0, gapsin:0
        workspace = f[1]s[false], gapsout:0, gapsin:0
        windowrule = border_size 0, match:float 0, match:workspace w[tv1]s[false]
        windowrule = rounding 0, match:float 0, match:workspace w[tv1]s[false]
        windowrule = border_size 0, match:float 0, match:workspace f[1]s[false]
        windowrule = rounding 0, match:float 0, match:workspace f[1]s[false]
        workspace = s[1], gapsout:80, gapsin:24
        windowrule = opacity 1.0 override 1.0 override 1.0 override, match:class ^(dev\.zed\.Zed)$
      ''
    ];
  };
}
