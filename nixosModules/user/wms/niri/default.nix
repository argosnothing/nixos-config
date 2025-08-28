{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    ../../ricing/quickshell
    ./wofi.nix
  ];
  options = {
    wms.niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Niri Wayland compositor.";
    };
  };
  config = lib.mkIf config.wms.niri.enable {
    # Enable QuickShell for niri
    quickshell.enable = true;
    home.packages = with pkgs; [
      wireplumber
      bibata-cursors
      nwg-displays
      grim
      libsoup_3
      qogir-icon-theme
      alsa-utils
      fontconfig
      freetype
      xwayland
      xwayland-satellite
    ];
    home.sessionVariables = {
      XCURSOR_THEME = "Quogir";
      XCURSOR_SIZE = "24";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      ELECTRON_NO_ASAR = "1";
      ELECTRON_ENABLE_LOGGING = "0";

      NIXOS_OZONE_WL = "1";
    };
    programs.yazi = {
      enable = true;
      settings = {
        mgr = {
          show_hidden = true;
        };
      };
    };

    programs.niri = {
      enable = true;
      settings = {
        environment."NIXOS_OZONE_WL" = "1";
        environment."DISPLAY" = ":0";
        
        spawn-at-startup = [
          {command = ["xwayland-satellite"];}
          {command = ["swww-daemon"];}
        ];
        
        input = {
          keyboard.xkb.layout = "us";
          touchpad = {
            tap = true;
            natural-scroll = true;
          };
          mouse = {
            "accel-profile" = "flat";
          };
        };

        # Basic keybindings (using Alt as modifier)
        binds = with config.lib.niri.actions; {
          # System shortcuts
          "Alt+Shift+Slash".action = show-hotkey-overlay;
          "Alt+Shift+E".action = quit;

          # Applications
          "Alt+Return".action = spawn "kitty";
          "Alt+T".action = spawn "kitty";
          "Alt+Space".action = spawn "wofi" "--show" "drun";
          "Alt+R".action = spawn "wofi" "--show" "run";

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
          "Alt+Z".action = consume-window-into-column;  # Pull adjacent window into this column
          "Alt+X".action = expel-window-from-column;    # Push window out to its own column

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
          "Alt+W".action = focus-workspace-up;    # Mirror for other hand
          "Alt+K".action = focus-workspace-down;
          "Alt+S".action = focus-workspace-down;  # Mirror for other hand          # Move window to workspace (relative movement - niri doesn't support direct workspace numbers)
          "Alt+Shift+I".action.move-column-to-workspace-up = { focus = true; };
          "Alt+Shift+W".action.move-column-to-workspace-up = { focus = true; };
          "Alt+Shift+K".action.move-column-to-workspace-down = { focus = true; };
          "Alt+Shift+S".action.move-column-to-workspace-down = { focus = true; };

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

        # Layout configuration
        layout = {
          gaps = 8;  # Reduced from 16 to 8 for less spacing
          focus-ring.enable = false;  # Disable the ugly border around focused windows
          preset-column-widths = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];
        };
      };
    };
  };
}
