{
  flake.modules.nixos.mango = {lib, ...}: {
    my.wm.mango.settings = lib.mkAfter [
      ''
        # Misc
        no_border_when_single=0
        focus_cross_monitor=1
        axis_bind_apply_timeout=100
        focus_on_activate=1
        inhibit_regardless_of_visibility=0
        sloppyfocus=1
        warpcursor=1
        focus_cross_monitor=0
        focus_cross_tag=0
        enable_floating_snap=0
        snap_distance=30
        cursor_size=24
        drag_tile_to_tile=1
        env=DISPLAY,:11
        # fcitx5 im
        env=GTK_IM_MODULE,fcitx
        env=QT_IM_MODULE,fcitx
        env=SDL_IM_MODULE,fcitx
        env=XMODIFIERS,@im=fcitx
        env=GLFW_IM_MODULE,ibus
        env=QT_QPA_PLATFORM,Wayland;xcb
      ''
    ];
  };
}
