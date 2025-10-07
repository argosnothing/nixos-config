{
  pkgs,
  settings,
  config,
  lib,
  ...
}: let
  recording-widget = import ./recording-widget.nix {inherit pkgs;};
  waybar-css = import ./style.nix {inherit config lib;};
in {
  config = lib.mkIf config.my.modules.gui.wms.mango.enable {
    hjem.users.${settings.username} = {
      packages = [
        recording-widget
        pkgs.waybar
      ];
      files = {
        ".config/waybar/style.css".text = waybar-css;
        ".config/waybar/config.jsonc" = {
          generator = lib.generators.toJSON {};
          value = {
            layer = "top";
            position = "top";
            height = 25;

            modules-left = ["ext/workspaces" "dwl/window"];
            modules-center = [];
            modules-right = [
              "custom/recorder"
              "custom/space"
              "clock"
              "custom/space"
              "pulseaudio"
              "custom/space"
              "custom/notification"
              "custom/space"
              "tray"
              "custom/space"
            ];

            "ext/workspaces" = {
              "format" = "{icon}";
              "ignore-hidden" = false;
              "on-click" = "activate";
              "sort-by-id" = true;
              "persistent-workspaces" = [1 2 3 4 5 6 7 8 9];
            };

            "custom/recorder" = {
              format = "{}";
              exec = "rec-widget status";
              "exec-on-event" = true;
              signal = 8;
              "on-click" = "rec-widget toggle";
            };

            "dwl/layout" = {
              format = "{}";
              "max-length" = 20;
            };

            "dwl/window" = {
              "format" = "[{layout}]{title} {app_id}";
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
        };
      };
    };
  };
}
