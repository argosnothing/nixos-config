{
  pkgs,
  config,
  lib,
  settings,
  ...
}: let
  hyprlandLocal = ".local/share/hyprland/";
in {
  imports = [
    ./config
  ];
  options = {
    wms.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland Wayland compositor.";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "hyprland") {
    custom.desktop-shell.name = "noctalia-shell";
    wms.hyprland.enable = true;
    styles.stylix.enable = true;
    custom.persist.home.files = ["${hyprlandLocal}/lastNag" "${hyprlandLocal}/lastVersion"];
    home = {
      packages = with pkgs; [
        wireplumber
        bibata-cursors
        hyprpicker
        hyprshot
        nwg-displays
        hyprpolkitagent
        grim
        slurp
        gvfs
        gtksourceview3
        libsoup_3
        qogir-icon-theme
        alsa-utils
        fontconfig
        freetype
      ];

      file.".config/fontconfig/fonts.conf".text = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <match target="font">
            <edit name="antialias" mode="assign">
              <bool>true</bool>
            </edit>
            <edit name="hinting" mode="assign">
              <bool>true</bool>
            </edit>
            <edit name="hintstyle" mode="assign">
              <const>hintslight</const>
            </edit>
            <edit name="rgba" mode="assign">
              <const>rgb</const>
            </edit>
            <edit name="lcdfilter" mode="assign">
              <const>lcddefault</const>
            </edit>
          </match>
        </fontconfig>
      '';

      sessionVariables = {
        XCURSOR_THEME = "Qogir";
        XCURSOR_SIZE = "24";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        ELECTRON_NO_ASAR = "1";
        ELECTRON_ENABLE_LOGGING = "0";
        NIXOS_OZONE_WL = "1";
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      plugins = [
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

        # NoBinds submap - disables all mainMod keybinds for remote desktop use
        submap = nobinds
        bind = , XF86Tools, submap, reset
        submap = reset
      '';
      settings = {
        "$terminal" = "kitty";
        "$menu" = config.custom.desktop-shell.launcherCommand;
        "$mainMod" = "MOD1";
        "$lockCommand" = "loginctl lock-session";

        monitor =
          if (settings.hostname == "desktop")
          then [
            "DP-1,3840x2160@160,0x0,1.25"
            "DP-2,1920x1080,3072x288,1.0"
          ]
          else [",preferred,auto,auto"];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "XDG_DATA_DIRS,$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "ELECTRON_NO_ASAR,1"
          "ELECTRON_ENABLE_LOGGING,0"
          "CHROMIUM_FLAGS,--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
          "GDK_SCALE,1"
          "GDK_DPI_SCALE,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_SCALE_FACTOR,1"
          "FREETYPE_PROPERTIES,truetype:interpreter-version=40"
          "QT_FONT_DPI,96"
          "QT_WAYLAND_FORCE_DPI,96"
          "QT_XFT_ANTIALIAS,1"
          "QT_XFT_HINTING,1"
          "QT_XFT_HINTSTYLE,hintslight"
          "QT_XFT_RGBA,rgb"
          "XWAYLAND_NO_GLAMOR,0"
          "_JAVA_AWT_WM_NONREPARENTING,1"
        ];

        exec-once =
          [
            "dbus-update-activation-environment --all"
            "/usr/bin/gnome-keyring-daemon --start --components=secrets"
            "exec /usr/libexec/pam_kwallet_init"
            "swayidle -w -C /usr/share/swayidle/config"
            "swww-daemon"
          ]
          ++ [
            config.custom.desktop-shell.execCommand
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
          rounding = 20;
          active_opacity = 0.95;
          inactive_opacity = 0.95;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };
          blur = {
            enabled = true;
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

        xwayland = {
          use_nearest_neighbor = false;
          force_zero_scaling = true;
        };

        misc = {
          disable_hyprland_logo = true;
          middle_click_paste = false;
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

        workspace = [
          "special:specq, gapsin:15, gapsout:50"
          "special:specw, gapsin:15, gapsout:50"
          "special:spece, gapsin:15, gapsout:50"
          "special:specs, gapsin:15, gapsout:50"
        ];
        #  ++ if (settings.hostname == "desktop")
        #  then [
        #    "m[DP-1] r[1-5]"
        #    "m[DP-2] r[6-9]"
        #  ]
        #  else [""];

        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "float,title:.*vim.*"
        ];

        bind =
          [
            "ALT1 CTRL SHIFT, S, exec, env GRIMBLAST_HIDE_CURSOR=1 grimblast copy area"
            "$mainMod, R, submap, resize"
            "$mainMod SHIFT, R, exec, pkill -SIGUSR2 waybar"
            "$mainMod, Return, exec, $terminal"
            "$mainMod Shift, Return, exec, [float; move cursor -50% -50%; size 50% 50%] $terminal vim"
            "$mainMod CTRL, S, exec, [float; move cursor -50% -50%] $terminal ns"
            "$mainMod, C, killactive,"
            "$mainMod, V, togglefloating,"
            "$mainMod, space, exec, $menu"
            "$mainMod, P, exec, hyprctl dispatch setfloating active && hyprctl dispatch resizewindowpixel exact 800 600 && hyprctl dispatch pin"
            "$mainMod, F, fullscreen"
            "$mainMod Shift, L, exec, $lockCommand"
            ", XF86Tools, submap, nobinds"
          ]
          ++ config.hyprland.navBindings;

        bindm = [
          "$mainMod, mouse:274, movewindow"
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
  };
}
