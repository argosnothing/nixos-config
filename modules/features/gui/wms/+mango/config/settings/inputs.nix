{
  flake.modules.nixos.mango = {lib, ...}: {
    my.wm.mango.settings = lib.mkAfter [
      ''
        # keyboard
        repeat_rate=25
        repeat_delay=400
        numlockon=1
        xkb_rules_layout=us

        # Trackpad
        # need relogin to make it apply
        disable_trackpad=0
        tap_to_click=1
        tap_and_drag=1
        drag_lock=1
        trackpad_natural_scrolling=1
        disable_while_typing=1
        left_handed=0
        middle_button_emulation=0
        swipe_min_threshold=1

        # mouse
        # need relogin to make it apply
        mouse_natural_scrolling=0
        accel_profile=0
        accel_speed=-0.55
      ''
    ];
  };
}
