{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        xwayland {
            force_zero_scaling = true
        }
        misc {
            force_default_wallpaper = 0
            disable_hyprland_logo = true
        }
      ''
    ];
  };
}
