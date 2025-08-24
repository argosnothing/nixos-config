{
  navBindings = [
    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"

    "$mainMod, j,  focusworkspaceoncurrentmonitor, r-1"
    "$mainMod, l,  focusworkspaceoncurrentmonitor, r+1"
    "$mainMod SHIFT, j,  movetoworkspace, e-1"
    "$mainMod SHIFT, j,  workspace,       e-1"
    "$mainMod SHIFT, l,  movetoworkspace, e+1"
    "$mainMod SHIFT, l,  workspace,       e+1"

    "$mainMod, a,  focusworkspaceoncurrentmonitor, r-1"
    "$mainMod, d,  focusworkspaceoncurrentmonitor, r+1"
    "$mainMod SHIFT, a,  movetoworkspace, e-1"
    "$mainMod SHIFT, a,  workspace,       e-1"
    "$mainMod SHIFT, d,  movetoworkspace, e+1"
    "$mainMod SHIFT, d,  workspace,       e+1"

    "$mainMod, 1, exec, context-aware-workspace 1"
    "$mainMod, 2, exec, context-aware-workspace 2"
    "$mainMod, 3, exec, context-aware-workspace 3"
    "$mainMod, 4, exec, context-aware-workspace 4"
    "$mainMod, 5, exec, context-aware-workspace 5"
    "$mainMod, 6, exec, context-aware-workspace 6"
    "$mainMod, 7, exec, context-aware-workspace 7"
    "$mainMod, 8, exec, context-aware-workspace 8"
    "$mainMod, 9, exec, context-aware-workspace 9"
    "$mainMod, 0, workspace, 10"

    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, 6, movetoworkspace, 6"
    "$mainMod SHIFT, 7, movetoworkspace, 7"
    "$mainMod SHIFT, 8, movetoworkspace, 8"
    "$mainMod SHIFT, 9, movetoworkspace, 9"
    "$mainMod SHIFT, 0, movetoworkspace, 10"

    # Hide any currently visible special workspace (never toggle, always hide)
    "$mainMod, Escape, togglespecialworkspace,"  # hide current special workspace

    # Show special workspace status 
    "$mainMod SHIFT, Escape, exec, kitty --class floating-terminal -e bash -c 'special-workspace-status; echo; echo \"Press any key to close...\"; read -n 1'"  # show special workspace status

    # Special workspaces spec1-spec9 with $mainMod CTRL 1-9
    "$mainMod CTRL, 1, togglespecialworkspace, spec1"
    "$mainMod CTRL, 2, togglespecialworkspace, spec2"
    "$mainMod CTRL, 3, togglespecialworkspace, spec3"
    "$mainMod CTRL, 4, togglespecialworkspace, spec4"
    "$mainMod CTRL, 5, togglespecialworkspace, spec5"
    "$mainMod CTRL, 6, togglespecialworkspace, spec6"
    "$mainMod CTRL, 7, togglespecialworkspace, spec7"
    "$mainMod CTRL, 8, togglespecialworkspace, spec8"
    "$mainMod CTRL, 9, togglespecialworkspace, spec9"

    # Move window to special workspaces spec1-spec9 with $mainMod CTRL SHIFT 1-9
    "$mainMod CTRL SHIFT, 1, movetoworkspace, special:spec1"
    "$mainMod CTRL SHIFT, 2, movetoworkspace, special:spec2"
    "$mainMod CTRL SHIFT, 3, movetoworkspace, special:spec3"
    "$mainMod CTRL SHIFT, 4, movetoworkspace, special:spec4"
    "$mainMod CTRL SHIFT, 5, movetoworkspace, special:spec5"
    "$mainMod CTRL SHIFT, 6, movetoworkspace, special:spec6"
    "$mainMod CTRL SHIFT, 7, movetoworkspace, special:spec7"
    "$mainMod CTRL SHIFT, 8, movetoworkspace, special:spec8"
    "$mainMod CTRL SHIFT, 9, movetoworkspace, special:spec9"

    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
  ];
}
