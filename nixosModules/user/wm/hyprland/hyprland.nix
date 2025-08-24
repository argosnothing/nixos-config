# modules/hyprland.nix
{pkgs, ...}: let
  navBindings = import ./config/nav-bindings.nix;
in {
  imports = [
    ./config/cursor.nix
    ./config/wallpaper-manager.nix
    ./waybar/waybar.nix
  ];
  home.packages = with pkgs; [
    wofi
    rofi
    bibata-cursors
    hyprpicker
    hyprshot
    hyprpolkitagent
    grim
    slurp
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprspace
    ];
    extraConfig = ''
      submap = resize
      bind = , H, resizeactive, -40 0
      bind = , L, resizeactive,  40 0
      bind = , J, resizeactive,  0 40
      bind = , K, resizeactive,  0 -40
      bind = , Escape, submap, reset
      bind = , R, submap, reset
      submap = reset
    '';
    settings = {
      # variables
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun --allow-images";
      "$mainMod" = "MOD1";
      "$lockCommand" = "loginctl lock-session";

      monitor = [",preferred,auto,auto"];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        
        # Flatpak app discovery
        "XDG_DATA_DIRS,$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
        
        # Electron/Chromium Wayland settings
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "ELECTRON_NO_ASAR,1"
        
        # Reduce Electron debug output
        "ELECTRON_ENABLE_LOGGING,0"
        "CHROMIUM_FLAGS,--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
      ];

      exec-once = [
        "dbus-update-activation-environment --all"
        "/usr/bin/gnome-keyring-daemon --start --components=secrets"
        "exec /usr/libexec/pam_kwallet_init"
        "swayidle -w -C /usr/share/swayidle/config"
        "swww-daemon"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 2;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, slide"
          "workspacesIn, 1, 1.21, almostLinear, slide"
          "workspacesOut, 1, 1.94, almostLinear, slide"
          "specialWorkspace, 1, 4, easeOutQuint, slidefadevert -50%"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        #force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        middle_click_paste = false;
      };

      plugin = {
        overview = {
          affectStrut = false;
          exitOnClick = true;
          exitOnSwitch = true;
        };
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "lv3:ralt_switch";
        kb_rules = "";
        follow_mouse = 1;
        force_no_accel = true;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };

      gestures.workspace_swipe = true;

      # rules & workspace config
      windowrulev2 = [
        "opacity 0.85 0.75, onworkspace:special:specq"
        "opacity 0.85 0.75, onworkspace:special:specw"
        "opacity 0.85 0.75, onworkspace:special:spece"
        "opacity 0.85 0.75, onworkspace:special:specs"
      ];

      workspace = [
        "special:specq, gapsin:15, gapsout:120"
        "special:specw, gapsin:15, gapsout:120"
        "special:spece, gapsin:15, gapsout:120"
        "special:specs, gapsin:15, gapsout:120"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      bind = [
        "$mainMod SHIFT, S, exec, env GRIMBLAST_HIDE_CURSOR=1 grimblast copy area"
        "$mainMod, R, submap, resize"
        "$mainMod SHIFT, R, exec, pkill -SIGUSR2 waybar"
        "$mainMod, Return, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, space, exec, $menu"
        "$mainMod, P, exec, hyprctl dispatch setfloating active && hyprctl dispatch resizewindowpixel exact 800 600 && hyprctl dispatch pin"
        "$mainMod, F, fullscreen"
        "$mainMod Shift, L, exec, $lockCommand"
        "$mainMod, Tab, overview:toggle"
      ] ++ navBindings.navBindings;

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
