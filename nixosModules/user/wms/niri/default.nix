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
    programs.niri = {
      enable = true;
      settings = {
        # Basic input configuration
        environment."NIXOS_OZONE_WL" = "1";
        environment."DISPLAY" = ":0";
        
        spawn-at-startup = [
          {command = ["xwayland-satellite"];}
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
          "Alt+Q".action = close-window;
          "Alt+F".action = maximize-column;
          "Alt+Shift+F".action = fullscreen-window;

          # Navigation (A/D for left/right, J/K for up/down)
          "Alt+A".action = focus-column-left;
          "Alt+D".action = focus-column-right;
          "Alt+J".action = focus-window-down;
          "Alt+K".action = focus-window-up;

          # Moving windows
          "Alt+Shift+A".action = move-column-left;
          "Alt+Shift+D".action = move-column-right;
          "Alt+Shift+J".action = move-window-down;
          "Alt+Shift+K".action = move-window-up;

          # Workspace navigation
          "Alt+1".action = focus-workspace 1;
          "Alt+2".action = focus-workspace 2;
          "Alt+3".action = focus-workspace 3;
          "Alt+4".action = focus-workspace 4;
          "Alt+5".action = focus-workspace 5;
          "Alt+6".action = focus-workspace 6;
          "Alt+7".action = focus-workspace 7;
          "Alt+8".action = focus-workspace 8;
          "Alt+9".action = focus-workspace 9;
          "Alt+0".action = focus-workspace 10;

          # Move windows to workspaces
          "Alt+Shift+1".action = move-column-to-workspace 1;
          "Alt+Shift+2".action = move-column-to-workspace 2;
          "Alt+Shift+3".action = move-column-to-workspace 3;
          "Alt+Shift+4".action = move-column-to-workspace 4;
          "Alt+Shift+5".action = move-column-to-workspace 5;
          "Alt+Shift+6".action = move-column-to-workspace 6;
          "Alt+Shift+7".action = move-column-to-workspace 7;
          "Alt+Shift+8".action = move-column-to-workspace 8;
          "Alt+Shift+9".action = move-column-to-workspace 9;
          "Alt+Shift+0".action = move-column-to-workspace 10;

          # Column resizing
          "Alt+H".action = set-column-width "-10%";
          "Alt+L".action = set-column-width "+10%";
          "Alt+Shift+H".action = set-window-height "-10%";
          "Alt+Shift+L".action = set-window-height "+10%";

          # Screenshots
          "Alt+S".action = screenshot;
          "Alt+Shift+S".action = screenshot-window;

          # Media keys
          "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        };

        # Layout configuration
        layout = {
          gaps = 16;
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
