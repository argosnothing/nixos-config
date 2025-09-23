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

        "modules-left" = ["ext/workspaces" "dwl/layout"];
        "modules-center" = ["dwl/window"];
        "modules-right" = ["clock" "pulseaudio" "custom/notification" "tray" "wlr/taskbar"];

        "ext/workspaces" = {
          "format" = "{icon}";
          "ignore-hidden" = true;
          "on-click" = "activate";
          "sort-by-id" = true;
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
          # app_id (from wlroots) and title together
          format = "{app_id} {title}";
          "max-length" = 80;
          "hide-empty" = true; # module disappears if no window is focused
        };

        "wlr/taskbar#current" = {
          format = "{icon} {title}";
          "icon-size" = 18;
          "icon-theme" = "Papirus"; # use your theme; colored icons come from here
          all-outputs = true;
          on-click = "activate";
          on-click-middle = "close";
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

      style = waybarCss;
    };
  };
}
