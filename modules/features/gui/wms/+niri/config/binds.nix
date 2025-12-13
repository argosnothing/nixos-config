{
  flake.modules.nixos.niri = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.my) desktop-shells;
    launcherArgs = lib.concatMapStringsSep " " (arg: ''"${arg}"'') (lib.splitString " " desktop-shells.launcherCommand);
  in {
    my.wm.niri.settings = lib.mkAfter [
      ''
        binds {
          Mod+Return { spawn "kitty"; }
          Mod+Shift+G { spawn "kitty" "-T" "pamix" "${lib.getExe pkgs.pamix}"; }
          Mod+space { spawn ${launcherArgs}; }
          Mod+Slash { show-hotkey-overlay; }
          Mod+O repeat=false { toggle-overview; }
          Mod+Escape repeat=false { close-window; }
          //Mod+0 { toggle-workspace-visibility "stash"; }

         Alt+Q            { spawn "niri-scratchpad" "create" "1" "--as-float"; }
         Alt+E            { spawn "niri-scratchpad" "create" "2" "--as-float"; }
         Alt+G            { spawn "niri-scratchpad" "create" "3" "--as-float"; }
         Alt+P            { spawn "niri-scratchpad" "create" "4" "--as-float"; }
         Mod+Q            { spawn "niri-scratchpad" "create" "1" "--as-float"; }
         Mod+E            { spawn "niri-scratchpad" "create" "2" "--as-float"; }
         Mod+G            { spawn "niri-scratchpad" "create" "3" "--as-float"; }
         Mod+P            { spawn "niri-scratchpad" "create" "4" "--as-float"; }
         Mod+Ctrl+Q       { spawn "niri-scratchpad" "delete" "1"; }
         Mod+Ctrl+E       { spawn "niri-scratchpad" "delete" "2"; }
         Mod+Ctrl+G       { spawn "niri-scratchpad" "delete" "3"; }
         Mod+Ctrl+P       { spawn "niri-scratchpad" "delete" "4"; }

          //Alt+P            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "1" "--as-float"; }
          //Alt+Q            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "2" "--as-float"; }
          //Alt+E            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "3" "--as-float"; }
          //Alt+G            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "4" "--as-float"; }
          //Mod+Q            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "1" "--as-float"; }
          //Mod+E            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "2" "--as-float"; }
          //Mod+G            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "3" "--as-float"; }
          //Mod+P            { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "create" "4" "--as-float"; }
          //Mod+Ctrl+Q       { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "delete" "1"; }
          //Mod+Ctrl+E       { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "delete" "2"; }
          //Mod+Ctrl+G       { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "delete" "3"; }
          //Mod+Ctrl+P       { spawn "/home/salivala/Projects/niri-scratchpad/target/debug/niri-scratchpad" "delete" "4"; }

          Mod+Down { focus-window-down; }
          Mod+Up { focus-window-up; }

          Mod+Left { focus-column-left; }
          Mod+Right { focus-column-right; }

          Mod+H { focus-column-left; }
          Mod+A { focus-column-left; }

          Mod+L { focus-column-right; }
          Mod+D { focus-column-right; }

          Mod+J { focus-window-down; }
          Mod+K { focus-window-up; }

          Mod+Ctrl+Left { move-column-left; }
          Mod+Ctrl+H { move-column-left; }
          Mod+Ctrl+A { move-column-left; }

          Mod+Ctrl+Right { move-column-right; }
          Mod+Ctrl+L { move-column-right; }
          Mod+Ctrl+D { move-column-right; }

          Mod+Ctrl+Down { move-window-down; }
          Mod+Ctrl+Up { move-window-up; }
          Mod+Ctrl+J { move-window-down; }
          Mod+Ctrl+K { move-window-up; }

          Mod+Home { focus-column-first; }
          Mod+End { focus-column-last; }
          Mod+Ctrl+Home { move-column-to-first; }
          Mod+Ctrl+End { move-column-to-last; }

          Mod+Shift+Left { focus-monitor-left; }
          Mod+Shift+H { focus-monitor-left; }
          Mod+Shift+A { focus-monitor-left; }

          Mod+Shift+Down { focus-monitor-down; }
          Mod+Shift+Up { focus-monitor-up; }

          Mod+Shift+Right { focus-monitor-right; }
          Mod+Shift+L { focus-monitor-right; }
          Mod+Shift+D { focus-monitor-right; }

          Mod+Shift+J { focus-monitor-down; }
          Mod+Shift+K { focus-monitor-up; }

          Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }
          Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
          Mod+Shift+Ctrl+A { move-column-to-monitor-left; }

          Mod+Shift+Ctrl+Down { move-column-to-monitor-down; }
          Mod+Shift+Ctrl+Up { move-column-to-monitor-up; }
          Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
          Mod+Shift+Ctrl+K { move-column-to-monitor-up; }

          Mod+Shift+Ctrl+L { move-column-to-monitor-right; }
          Mod+Shift+Ctrl+D { move-column-to-monitor-right; }
          Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }

          Mod+S { focus-workspace-down; }
          Mod+Page_Down { focus-workspace-down; }
          Mod+U { focus-workspace-down; }

          Mod+Page_Up { focus-workspace-up; }
          Mod+I { focus-workspace-up; }
          Mod+W { focus-workspace-up; }

          Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
          Mod+Ctrl+S { move-column-to-workspace-down; }

          Mod+Ctrl+Page_Up { move-column-to-workspace-up; }

          Mod+Ctrl+U { move-column-to-workspace-down; }
          Mod+Ctrl+I { move-column-to-workspace-up; }
          Mod+Ctrl+W { move-column-to-workspace-up; }

          Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }

          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
          Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }

          Mod+WheelScrollRight { focus-column-right; }
          Mod+WheelScrollLeft { focus-column-left; }
          Mod+Ctrl+WheelScrollRight { move-column-right; }
          Mod+Ctrl+WheelScrollLeft { move-column-left; }

          Mod+Shift+WheelScrollDown { focus-column-right; }
          Mod+Shift+WheelScrollUp { focus-column-left; }
          Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
          Mod+Ctrl+Shift+WheelScrollUp { move-column-left; }

          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }

          Mod+Ctrl+1 { move-column-to-workspace 1; }
          Mod+Ctrl+2 { move-column-to-workspace 2; }
          Mod+Ctrl+3 { move-column-to-workspace 3; }
          Mod+Ctrl+4 { move-column-to-workspace 4; }
          Mod+Ctrl+5 { move-column-to-workspace 5; }
          Mod+Ctrl+6 { move-column-to-workspace 6; }
          Mod+Ctrl+7 { move-column-to-workspace 7; }
          Mod+Ctrl+8 { move-column-to-workspace 8; }
          Mod+Ctrl+9 { move-column-to-workspace 9; }

          Mod+Shift+Comma { consume-or-expel-window-left; }
          Mod+Shift+Period { consume-or-expel-window-right; }

          Mod+Comma { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }

          Mod+R { switch-preset-column-width; }
          Mod+Shift+R { switch-preset-window-height; }
          Mod+Ctrl+R { reset-window-height; }

          Mod+F { maximize-window-to-edges; }
          Mod+Shift+F { fullscreen-window; }

          Mod+Ctrl+F { expand-column-to-available-width; }

          Mod+C { center-column; }
          Mod+Ctrl+C { center-visible-columns; }

          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }

          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          Mod+V { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }

          Mod+X { toggle-column-tabbed-display; }

          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }
          Mod+Ctrl+Shift+S { spawn "snip"; }

          Mod+Shift+E { quit; }
          Ctrl+Alt+Delete { quit; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
          XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
          XF86AudioPlay allow-when-locked=true { spawn "playerctl" "play-pause"; }
          XF86AudioStop allow-when-locked=true { spawn "playerctl" "stop"; }
          XF86AudioPrev allow-when-locked=true { spawn "playerctl" "previous"; }
          XF86AudioNext allow-when-locked=true { spawn "playerctl" "next"; }
          XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }
        }
      ''
    ];
  };
}
