{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        plugin {
            hyprsplit {
                num_workspaces = 9
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

        bind = SUPER SHIFT, 1, split:movetoworkspacesilent, 1
        bind = SUPER SHIFT, 2, split:movetoworkspacesilent, 2
        bind = SUPER SHIFT, 3, split:movetoworkspacesilent, 3
        bind = SUPER SHIFT, 4, split:movetoworkspacesilent, 4
        bind = SUPER SHIFT, 5, split:movetoworkspacesilent, 5
        bind = SUPER SHIFT, 6, split:movetoworkspacesilent, 6
        bind = SUPER SHIFT, 7, split:movetoworkspacesilent, 7
        bind = SUPER SHIFT, 8, split:movetoworkspacesilent, 8
        bind = SUPER SHIFT, 9, split:movetoworkspacesilent, 9

        bind = SUPER, U, split:workspace, +1
        bind = SUPER, I, split:workspace, -1

        bind = SUPER, D, split:swapactiveworkspaces, current +1
        bind = SUPER, G, split:grabroguewindows

        # Only bind if hyprsplit plugin is loaded, requires Hyprland >= v0.51.0
        # hyprlang if HYPRSPLIT
        bind = SUPER CONTROL, 1, split:movetoworkspace, 1
        # hyprlang endif
      ''
    ];
  };
}
