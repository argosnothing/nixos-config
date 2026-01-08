{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        plugin {
            hyprsplit {
                num_workspaces = 9
            }
            hyprscrolling {
              column_width = 0.7
              fullscreen_on_one_column = false
            }
        }

        bind = SUPER, 1, split:workspace, 1
        bind = SUPER, 2, split:workspace, 2
        bind = SUPER, 3, split:workspace, 3
        bind = SUPER, 4, split:workspace, 4
        bind = SUPER, 5, split:workspace, 5
        bind = SUPER, 6, split:workspace, 6
        bind = SUPER, 7, split:workspace, 7
        bind = SUPER, 8, split:workspace, 8
        bind = SUPER, 9, split:workspace, 9

        bind = SUPER, r, layoutmsg, colresize +conf

        bind = SUPER CTRL, 1, split:movetoworkspacesilent, 1
        bind = SUPER CTRL, 2, split:movetoworkspacesilent, 2
        bind = SUPER CTRL, 3, split:movetoworkspacesilent, 3
        bind = SUPER CTRL, 4, split:movetoworkspacesilent, 4
        bind = SUPER CTRL, 5, split:movetoworkspacesilent, 5
        bind = SUPER CTRL, 6, split:movetoworkspacesilent, 6
        bind = SUPER CTRL, 7, split:movetoworkspacesilent, 7
        bind = SUPER CTRL, 8, split:movetoworkspacesilent, 8
        bind = SUPER CTRL, 9, split:movetoworkspacesilent, 9

        bind = SUPER, U, split:workspace, +1
        bind = SUPER, I, split:workspace, -1
        bind = SUPER, S, split:workspace, +1
        bind = SUPER, W, split:workspace, -1
        bind = SUPER CTRL, U, split:movetoworkspace, +1
        bind = SUPER CTRL, I, split:movetoworkspace, -1
        bind = SUPER CTRL, S, split:movetoworkspace, +1
        bind = SUPER CTRL, W, split:movetoworkspace, -1

        # Only bind if hyprsplit plugin is loaded, requires Hyprland >= v0.51.0
        # hyprlang if HYPRSPLIT
        bind = SUPER CONTROL, 1, split:movetoworkspace, 1
        # hyprlang endif
      ''
    ];
  };
}
