{
  pkgs,
  config,
  lib,
  ...
}: let
  c = config.lib.stylix.colors;
  waybarCss = import ./style.nix {inherit config lib;};
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

        modules-left = ["ext/workspaces" "dwl/window"];
        modules-center = [];
        modules-right = [
          "clock"
          "custom/space"
          "pulseaudio"
          "custom/space"
          "custom/notification"
          "custom/space"
          "tray"
          "custom/space"
          "wlr/taskbar"
        ];

        "ext/workspaces" = {
          "format" = "{icon}";
          "ignore-hidden" = false;
          "on-click" = "activate";
          "sort-by-id" = true;
          "persistent-workspaces" = {"*" = [1 2 3 4 5 6 7 8 9];};
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

        "dwl/layout" = {
          format = "{}";
          "max-length" = 20;
        };

        "dwl/window" = {
          "format" = "[{layout}]{title}";
        };

        "custom/space" = {
          format = "   "; # three spaces
          interval = "once";
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
          format = "{:%I:%M %p  %m/%d/%Y}";
          "tooltip-format" = "<big>{:%A, %B %d, %Y}</big>";
        };

        "custom/notification" = {
          format = " {text}";
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          escape = true;
          interval = 0;
        };
      };

      style = waybarCss;
    };
  };
}
