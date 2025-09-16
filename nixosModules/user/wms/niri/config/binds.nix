{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # System shortcuts
    "Alt+Shift+Slash".action = show-hotkey-overlay;
    "Alt+Shift+E".action = quit;

    # Applications
    "Alt+Return".action = spawn "kitty";
    "Alt+T".action = spawn "kitty";
    "Alt+E".action = spawn "kitty" "-e" "yazi"; # Terminal file manager
    "Alt+N".action = spawn "nemo"; # GUI file manager
    "Alt+Space".action = spawn "noctalia-shell" "ipc" "call" "launcher" "toggle";
    "Alt+R".action = spawn "wofi" "--show" "run";
    "Alt+Q".action.focus-workspace = "discord"; # Go to Discord workspace

    # Window management
    "Alt+C".action = close-window;
    "Alt+F".action = maximize-column;
    "Alt+Shift+F".action = fullscreen-window;

    # Navigation (A/J for left, D/L for right - two ways for each direction)
    "Alt+A".action = focus-column-left;
    "Alt+J".action = focus-column-left;
    "Alt+D".action = focus-column-right;
    "Alt+L".action = focus-column-right;

    # Moving windows (same pattern for moving)
    "Alt+Shift+A".action = move-column-left;
    "Alt+Shift+J".action = move-column-left;
    "Alt+Shift+D".action = move-column-right;
    "Alt+Shift+L".action = move-column-right;

    # Window stacking
    "Alt+Z".action = consume-window-into-column; # Pull adjacent window into this column
    "Alt+X".action = expel-window-from-column; # Push window out to its own column

    # Workspace navigation (1-10)
    "Alt+1".action.focus-workspace = 1;
    "Alt+2".action.focus-workspace = 2;
    "Alt+3".action.focus-workspace = 3;
    "Alt+4".action.focus-workspace = 4;
    "Alt+5".action.focus-workspace = 5;
    "Alt+6".action.focus-workspace = 6;
    "Alt+7".action.focus-workspace = 7;
    "Alt+8".action.focus-workspace = 8;
    "Alt+9".action.focus-workspace = 9;
    "Alt+0".action.focus-workspace = 10;

    # Workspace navigation (up/down - mirrored like left/right navigation)
    "Alt+I".action = focus-workspace-up;
    "Alt+W".action = focus-workspace-up; # Mirror for other hand
    "Alt+K".action = focus-workspace-down;
    "Alt+S".action = focus-workspace-down; # Mirror for other hand          # Move window to workspace (relative movement - niri doesn't support direct workspace numbers)
    "Alt+Shift+I".action.move-column-to-workspace-up = {focus = true;};
    "Alt+Shift+W".action.move-column-to-workspace-up = {focus = true;};
    "Alt+Shift+K".action.move-column-to-workspace-down = {focus = true;};
    "Alt+Shift+S".action.move-column-to-workspace-down = {focus = true;};

    # Column resizing (Alt+- to make smaller, Alt+= to make bigger)
    "Alt+minus".action = set-column-width "-10%";
    "Alt+equal".action = set-column-width "+10%";
    "Alt+Shift+minus".action = set-window-height "-10%";
    "Alt+Shift+equal".action = set-window-height "+10%";

    # Screenshots
    "Alt+Shift+P".action = screenshot;
    "Alt+Shift+O".action = screenshot-window;

    # Media keys
    "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
    "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
  };
}
