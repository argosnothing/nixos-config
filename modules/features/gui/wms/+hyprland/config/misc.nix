{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        exec-once = hyprctl plugin load "$HYPR_PLUGIN_DIR/lib/libhyprsplit.so"
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
