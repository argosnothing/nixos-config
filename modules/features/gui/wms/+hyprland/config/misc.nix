{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        # load all the plugins you installed
        exec-once = hyprctl plugin load "$HYPR_PLUGIN_DIR/lib/libhyprsplit.so"
        # exec-once = hyprctl plugin load "$HYPR_PLUGIN_DIR/lib/libhyprscrolling.so"
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
