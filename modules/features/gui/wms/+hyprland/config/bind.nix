{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        $mainMod = SUPER

        bind = $mainMod, Return, exec, $terminal
        bind = $mainMod, Escape, killactive,
        #bind = $mainMod SHIFT, E, exit,
        bind = $mainMod, E, exec, $fileManager
        bind = $mainMod, V, togglefloating,
        bind = $mainMod, Space, exec, $menu
        bind = SUPER, F, fullscreen, 1
        bind = SUPER SHIFT, F, fullscreen, 2
        bind = SUPER SHIFT, S, exec, snip


        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d
        bind = $mainMod, h, movefocus, l
        bind = $mainMod, l, movefocus, r
        bind = $mainMod, k, movefocus, u
        bind = $mainMod, j, movefocus, d

        bind = SUPER CTRL, A, movewindow, l
        bind = SUPER CTRL, D, movewindow, r
        bind = SUPER CTRL, H, movewindow, l
        bind = SUPER CTRL, L, movewindow, r
        bind = SUPER CTRL, K, movewindow, u
        bind = SUPER CTRL, J, movewindow, d

        bind = SUPER SHIFT, H, focusmonitor, l
        bind = SUPER SHIFT, L, focusmonitor, r
        bind = SUPER CTRL SHIFT, H, movewindow, mon:l
        bind = SUPER CTRL SHIFT, L, movewindow, mon:r


        bind = $mainMod, Q, togglespecialworkspace, q
        bind = $mainMod CTRL, Q, movetoworkspace, special:q
        bind = $mainMod, E, togglespecialworkspace, e
        bind = $mainMod CTRL, E, movetoworkspace, special:e
        bind = $mainMod, G, togglespecialworkspace, g
        bind = $mainMod CTRL, G, movetoworkspace, special:g

        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
        bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

        bindl = ,XF86AudioNext, exec, playerctl next
        bindl = ,XF86AudioPause, exec, playerctl play-pause
        bindl = ,XF86AudioPlay, exec, playerctl play-pause
        bindl = ,XF86AudioPrev, exec, playerctl previous
      ''
    ];
  };
}
