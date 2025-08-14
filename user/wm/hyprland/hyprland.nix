# modules/hyprland.nix
{ pkgs, inputs, config, lib, userSettings, systemSettings, ... }:
{
  imports = [
    ../../shell/cava/default.nix
    ../../app/terminal/kitty.nix
    ../../app/terminal/alacritty.nix
    ./filechooser/termfilechooser.nix
    ./waybar/waybar.nix
  ];
  home.packages = with pkgs; [
    wireplumber
    libgtop
    bluez
    networkmanager
    dart-sass
    wl-clipboard
    upower
    gvfs
    gtksourceview3
    libsoup_3
    grimblast
    jq
    wf-recorder
    hyprpicker
    btop
    matugen
    swww
    nwg-displays
    hyprpolkitagent
    alsa-utils  ];

  xdg.enable = true;
  programs.rofi.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprpolkitagent - Polkit authentication agent";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  #stylix.targets.hyprpaper.enable = true;
  services.hyprpaper.enable = true;

  stylix.targets.hyprland.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    settings = {
      # variables
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun -show-icons";
      "$mainMod" = "MOD5";
      "$lockCommand" = "loginctl lock-session";

      monitor = [ ",preferred,auto,auto" ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "dbus-update-activation-environment --all"
        "/usr/bin/gnome-keyring-daemon --start --components=secrets"
        "exec /usr/libexec/pam_kwallet_init"
        "swayidle -w -C /usr/share/swayidle/config"
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
          "specialWorkspace, 1, 8, default, slidefadevert -50%"
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
        #"opacity 0.5 0.6, onworkspace:special:magic"
      ];

      workspace = [
        "special:magic, gapsin:10, gapsout:90"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      # binds
      bind = [
        "SUPER SHIFT, S, exec, grimblast copy area"
        "$mainMod SHIFT, R, exec, pkill -SIGUSR2 waybar"
        "$mainMod, Return, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, space, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, F, fullscreen"
        "$mainMod Shift, L, exec, $lockCommand"

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

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
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

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

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
