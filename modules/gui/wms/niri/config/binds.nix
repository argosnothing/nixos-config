{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf mkDefault;
in {
  config = mkIf niri.enable {
    hm = _: let
      inherit (config.my.modules.gui) desktop-shells;
    in {
      programs.niri.settings.binds = mkDefault {
        "Mod+Return".action.spawn = "kitty";
        "Mod+space".action.spawn = lib.splitString " " desktop-shells.launcherCommand;
        "XF86AudioRaiseVolume"."allow-when-locked" = true;
        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];

        "XF86AudioLowerVolume"."allow-when-locked" = true;
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];

        "XF86AudioMute"."allow-when-locked" = true;
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];

        "XF86AudioMicMute"."allow-when-locked" = true;
        "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];

        "XF86AudioPlay"."allow-when-locked" = true;
        "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];

        "XF86AudioStop"."allow-when-locked" = true;
        "XF86AudioStop".action.spawn = ["playerctl" "stop"];

        "XF86AudioPrev"."allow-when-locked" = true;
        "XF86AudioPrev".action.spawn = ["playerctl" "previous"];

        "XF86AudioNext"."allow-when-locked" = true;
        "XF86AudioNext".action.spawn = ["playerctl" "next"];

        "XF86MonBrightnessUp"."allow-when-locked" = true;
        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];

        "XF86MonBrightnessDown"."allow-when-locked" = true;
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];

        "Mod+O".repeat = false;
        "Mod+O".action.toggle-overview = [];

        "Mod+Q".repeat = false;
        "Mod+Q".action.close-window = [];

        "Mod+Left".action.focus-column-left = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+H".action.focus-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+L".action.focus-column-right = [];

        "Mod+Ctrl+Left".action.move-column-left = [];
        "Mod+Ctrl+Down".action.move-window-down = [];
        "Mod+Ctrl+Up".action.move-window-up = [];
        "Mod+Ctrl+Right".action.move-column-right = [];
        "Mod+Ctrl+H".action.move-column-left = [];
        "Mod+Ctrl+J".action.move-window-down = [];
        "Mod+Ctrl+K".action.move-window-up = [];
        "Mod+Ctrl+L".action.move-column-right = [];

        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Ctrl+Home".action.move-column-to-first = [];
        "Mod+Ctrl+End".action.move-column-to-last = [];

        "Mod+Shift+Left".action.focus-monitor-left = [];
        "Mod+Shift+Down".action.focus-monitor-down = [];
        "Mod+Shift+Up".action.focus-monitor-up = [];
        "Mod+Shift+Right".action.focus-monitor-right = [];
        "Mod+Shift+H".action.focus-monitor-left = [];
        "Mod+Shift+J".action.focus-monitor-down = [];
        "Mod+Shift+K".action.focus-monitor-up = [];
        "Mod+Shift+L".action.focus-monitor-right = [];

        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

        "Mod+Page_Down".action.focus-workspace-down = [];
        "Mod+Page_Up".action.focus-workspace-up = [];
        "Mod+U".action.focus-workspace-down = [];
        "Mod+I".action.focus-workspace-up = [];

        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

        "Mod+WheelScrollDown"."cooldown-ms" = 150;
        "Mod+WheelScrollDown".action.focus-workspace-down = [];

        "Mod+WheelScrollUp"."cooldown-ms" = 150;
        "Mod+WheelScrollUp".action.focus-workspace-up = [];

        "Mod+Ctrl+WheelScrollDown"."cooldown-ms" = 150;
        "Mod+Ctrl+WheelScrollDown".action.move-column-to-workspace-down = [];

        "Mod+Ctrl+WheelScrollUp"."cooldown-ms" = 150;
        "Mod+Ctrl+WheelScrollUp".action.move-column-to-workspace-up = [];

        "Mod+WheelScrollRight".action.focus-column-right = [];
        "Mod+WheelScrollLeft".action.focus-column-left = [];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];

        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+BracketLeft".action.consume-or-expel-window-left = [];
        "Mod+BracketRight".action.consume-or-expel-window-right = [];

        "Mod+Comma" = lib.mkDefault {
          action.consume-window-into-column = [];
        };

        "Mod+Period".action.expel-window-from-column = [];

        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Shift+R".action.switch-preset-window-height = [];
        "Mod+Ctrl+R".action.reset-window-height = [];

        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];

        "Mod+Ctrl+F".action.expand-column-to-available-width = [];

        "Mod+C".action.center-column = [];
        "Mod+Ctrl+C".action.center-visible-columns = [];

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+V".action = mkDefault {
          toggle-window-floating = [];
        };
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

        "Mod+W".action.toggle-column-tabbed-display = [];

        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];
        "Mod+Ctrl+Shift+S".action.spawn = "snip";

        "Mod+Escape"."allow-inhibiting" = false;
        "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = [];

        "Mod+Shift+E".action.quit = [];
        "Ctrl+Alt+Delete".action.quit = [];

        "Mod+Shift+P".action.power-off-monitors = [];
      };
    };
  };
}
