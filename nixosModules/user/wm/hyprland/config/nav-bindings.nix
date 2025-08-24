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

    # Special workspaces with mainMod + qwes
    "$mainMod, q, togglespecialworkspace, specq"
    "$mainMod, w, togglespecialworkspace, specw"
    "$mainMod, e, togglespecialworkspace, spece"
    "$mainMod, s, togglespecialworkspace, specs"

    # Move window to special workspaces with mainMod SHIFT + qwes
    "$mainMod SHIFT, q, movetoworkspace, special:specq"
    "$mainMod SHIFT, w, movetoworkspace, special:specw"
    "$mainMod SHIFT, e, movetoworkspace, special:spece"
    "$mainMod SHIFT, s, movetoworkspace, special:specs"

    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
  ];
}
