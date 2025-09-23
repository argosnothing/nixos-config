{
  pkgs,
  config,
  lib,
  ...
}: let
  c = config.lib.stylix.colors; # <- normalized base16 colors from Stylix
in {
  config = lib.mkIf config.wms.mango.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
    programs.waybar = {
      enable = true;
      systemd.enable = false;
      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 25;

        "modules-left" = ["ext/workspaces"];
        "modules-center" = ["dwl/window"];
        "modules-right" = ["clock" "pulseaudio" "custom/notification" "tray" "wlr/taskbar"];

        "ext/workspaces" = {
          "format" = "{icon}";
          "ignore-hidden" = true;
          "on-click" = "activate";
          "sort-by-id" = true;
        };

        "dwl/window" = {
          format = "{}";
          "max-length" = 50;
          rewrite.".*" = "★ $0";
        };

        "wlr/taskbar" = {
          format = "{icon}";
          "icon-size" = 22;
          "markup" = true;
          "tooltip-format" = "{title}";
          "on-click" = "activate";
          "on-click-right" = "close";
          "ignore-list" = ["Wofi" "rofi"];
          "all-outputs" = false;
        };

        pulseaudio = {
          "disable-scroll" = true;
          "format" = "{icon} {volume}%";
          "format-muted" = "muted";
          "on-click" = "pavucontrol";
          "format-icons".default = ["" "" ""];
        };

        tray = {
          "icon-size" = 20;
          spacing = 6;
        };

        clock = {
          format = "{:%a %b %d  %H:%M}";
          "tooltip-format" = "<big>{:%Y-%m-%d}</big>";
        };

        "custom/notification" = {
          format = "{icon} {text}";
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          escape = true;
          interval = 0;
        };
      };

      style = ''
        @define-color bg      #${c.base00};
        @define-color bg2     #${c.base01};
        @define-color fg      #${c.base05};
        @define-color accent  #${c.base0D};
        @define-color red     #${c.base08};
        @define-color yellow  #${c.base0A};

        * { border: none; min-height: 0; font-size: 12px; }

        window#waybar { background: @bg; color: @fg; }

        #window, #taskbar, #tray, #pulseaudio, #clock {
          padding: 0 8px; margin: 0 4px;
          background: @bg2; border-radius: 10px;
        }

        #tags button, #workspaces button {
          padding: 0 6px; background: transparent; color: @fg;
        }
        #tags button.focused, #workspaces button.focused {
          background: alpha(@accent, 0.15);
        }
        #tags button.urgent, #workspaces button.urgent {
          background: alpha(@red, 0.25);
        }

        #taskbar button:checked { background: alpha(@accent, 0.25); }
        #pulseaudio.muted { color: @yellow; }
      '';
    };
  };
}
