{ config, pkgs, inputs, ... }:
let
  styles = config.lib.stylix.colors.withHashtag;
  bg0 = styles.base00;
  bg1 = styles.base01;
  bg2 = styles.base01;
  brd = styles.base02;
  sep = styles.base03;
  fg  = styles.base05;
  fg2 = styles.base06;

  red  = styles.base08;
  org  = styles.base09;
  yel  = styles.base0A;
  grn  = styles.base0B;
  cyn  = styles.base0C;
  blu  = styles.base0D;
  mag  = styles.base0E;
in {
  programs.hyprpanel.enable = true;

  systemd.user.services.hyprpanel.Service.Environment = [
    "GRIMBLAST_HIDE_CURSOR=1"
  ];

  programs.hyprpanel.settings = {
    bar.layouts = {
      "*" = {
        left = ["dashboard" "workspaces" "windowtitle"  ];
        middle = [ "media" ];
        right = [  "systray" "clock" "notifications" ]; # "dashboard" = the menu button
      };
    };
    bar.workspaces.ignored = "-\\d+";
    bar.launcher.autoDetectIcon = true;
    bar.workspaces.show_numbered = true;

    theme.font.size = "${toString config.stylix.fonts.sizes.applications}px";
    theme.bar.background = bg0;
    theme.bar.menus.background = bg0;
    theme.bar.menus.text = fg2;
    theme.bar.menus.border.color = brd;
    theme.bar.menus.popover.text = mag;
    theme.bar.menus.popover.background = bg0;
    theme.bar.menus.tooltip.text = fg2;
    theme.bar.menus.tooltip.background = bg0;
    theme.bar.menus.dropdownmenu.divider = bg2;
    theme.bar.menus.dropdownmenu.text = fg2;
    theme.bar.menus.dropdownmenu.background = bg0;

    theme.bar.menus.slider.puck = sep;
    theme.bar.menus.slider.backgroundhover = sep;
    theme.bar.menus.slider.background = sep;
    theme.bar.menus.slider.primary = mag;
    theme.bar.menus.progressbar.background = sep;
    theme.bar.menus.progressbar.foreground = mag;

    theme.bar.menus.iconbuttons.active  = mag;
    theme.bar.menus.iconbuttons.passive = fg2;
    theme.bar.menus.buttons.text      = bg0;
    theme.bar.menus.buttons.disabled  = sep;
    theme.bar.menus.buttons.active    = mag;
    theme.bar.menus.buttons.default   = mag;

    theme.bar.menus.switch.puck     = sep;
    theme.bar.menus.switch.disabled = brd;
    theme.bar.menus.switch.enabled  = mag;

    theme.bar.menus.icons.active  = mag;
    theme.bar.menus.icons.passive = sep;
    theme.bar.menus.listitems.active  = mag;
    theme.bar.menus.listitems.passive = fg2;
    theme.bar.menus.label     = mag;
    theme.bar.menus.feinttext = brd;
    theme.bar.menus.dimtext   = sep;

    theme.bar.menus.cards = bg2;

    # ---- per-menu: notifications ----
    theme.bar.menus.menu.notifications.background = bg0;
    theme.bar.menus.menu.notifications.card       = bg2;
    theme.bar.menus.menu.notifications.border     = brd;
    theme.bar.menus.menu.notifications.switch.puck     = sep;
    theme.bar.menus.menu.notifications.switch.disabled = brd;
    theme.bar.menus.menu.notifications.switch.enabled  = mag;
    theme.bar.menus.menu.notifications.switch_divider  = sep;
    theme.bar.menus.menu.notifications.clear           = red;
    theme.bar.menus.menu.notifications.no_notifications_label = brd;
    theme.bar.menus.menu.notifications.label = mag;
    theme.bar.menus.menu.notifications.pager.button     = mag;
    theme.bar.menus.menu.notifications.scrollbar.color  = mag;
    theme.bar.menus.menu.notifications.pager.label      = sep;
    theme.bar.menus.menu.notifications.pager.background = bg0;

    # ---- per-menu: dashboard ----
    theme.bar.menus.menu.dashboard.border.color     = brd;
    theme.bar.menus.menu.dashboard.background.color = bg0;
    theme.bar.menus.menu.dashboard.card.color       = bg2;

    theme.bar.menus.menu.dashboard.monitors.bar_background = sep;
    theme.bar.menus.menu.dashboard.monitors.disk.label = mag;
    theme.bar.menus.menu.dashboard.monitors.disk.bar   = mag;
    theme.bar.menus.menu.dashboard.monitors.disk.icon  = mag;
    theme.bar.menus.menu.dashboard.monitors.gpu.label = grn;
    theme.bar.menus.menu.dashboard.monitors.gpu.bar   = grn;
    theme.bar.menus.menu.dashboard.monitors.gpu.icon  = grn;
    theme.bar.menus.menu.dashboard.monitors.ram.label = yel;
    theme.bar.menus.menu.dashboard.monitors.ram.bar   = yel;
    theme.bar.menus.menu.dashboard.monitors.ram.icon  = yel;
    theme.bar.menus.menu.dashboard.monitors.cpu.label = red;
    theme.bar.menus.menu.dashboard.monitors.cpu.bar   = red;
    theme.bar.menus.menu.dashboard.monitors.cpu.icon  = red;

    theme.bar.menus.menu.dashboard.directories.right.bottom.color = mag;
    theme.bar.menus.menu.dashboard.directories.right.middle.color = mag;
    theme.bar.menus.menu.dashboard.directories.right.top.color    = cyn;
    theme.bar.menus.menu.dashboard.directories.left.bottom.color  = red;
    theme.bar.menus.menu.dashboard.directories.left.middle.color  = yel;
    theme.bar.menus.menu.dashboard.directories.left.top.color     = mag;

    theme.bar.menus.menu.dashboard.controls.input.text        = bg0;
    theme.bar.menus.menu.dashboard.controls.input.background  = mag;
    theme.bar.menus.menu.dashboard.controls.volume.text       = bg0;
    theme.bar.menus.menu.dashboard.controls.volume.background = red;
    theme.bar.menus.menu.dashboard.controls.notifications.text       = bg0;
    theme.bar.menus.menu.dashboard.controls.notifications.background = yel;
    theme.bar.menus.menu.dashboard.controls.bluetooth.text       = bg0;
    theme.bar.menus.menu.dashboard.controls.bluetooth.background = cyn;
    theme.bar.menus.menu.dashboard.controls.wifi.text       = bg0;
    theme.bar.menus.menu.dashboard.controls.wifi.background = mag;

    theme.bar.menus.menu.dashboard.controls.disabled = sep;

    theme.bar.menus.menu.dashboard.shortcuts.recording  = grn;
    theme.bar.menus.menu.dashboard.shortcuts.text       = bg0;
    theme.bar.menus.menu.dashboard.shortcuts.background = mag;

    theme.bar.menus.menu.dashboard.profile.name = mag;

    theme.bar.menus.menu.dashboard.powermenu.shutdown = red;
    theme.bar.menus.menu.dashboard.powermenu.sleep    = cyn;
    theme.bar.menus.menu.dashboard.powermenu.logout   = grn;
    theme.bar.menus.menu.dashboard.powermenu.restart  = org;

    theme.bar.menus.menu.dashboard.powermenu.confirmation.confirm       = grn;
    theme.bar.menus.menu.dashboard.powermenu.confirmation.deny          = red;
    theme.bar.menus.menu.dashboard.powermenu.confirmation.button_text   = bg0;
    theme.bar.menus.menu.dashboard.powermenu.confirmation.body          = fg2;
    theme.bar.menus.menu.dashboard.powermenu.confirmation.label         = mag;
    theme.bar.menus.menu.dashboard.powermenu.confirmation.border        = brd;
    theme.bar.menus.menu.dashboard.powermenu.confirmation.background    = bg0;
    theme.bar.menus.menu.dashboard.powermenu.confirmation.card          = bg2;

    # ---- per-menu: clock & weather ----
    theme.bar.menus.menu.clock.border.color     = brd;
    theme.bar.menus.menu.clock.background.color = bg0;
    theme.bar.menus.menu.clock.card.color       = bg2;
    theme.bar.menus.menu.clock.text             = fg2;
    theme.bar.menus.menu.clock.time.time        = mag;
    theme.bar.menus.menu.clock.time.timeperiod  = cyn;

    theme.bar.menus.menu.clock.weather.icon         = mag;
    theme.bar.menus.menu.clock.weather.temperature  = fg2;
    theme.bar.menus.menu.clock.weather.status       = cyn;
    theme.bar.menus.menu.clock.weather.stats        = mag;
    theme.bar.menus.menu.clock.weather.hourly.icon        = mag;
    theme.bar.menus.menu.clock.weather.hourly.time        = mag;
    theme.bar.menus.menu.clock.weather.hourly.temperature = mag;
    theme.bar.menus.menu.clock.weather.thermometer.extremelycold = cyn;
    theme.bar.menus.menu.clock.weather.thermometer.cold          = blu;
    theme.bar.menus.menu.clock.weather.thermometer.moderate      = mag;
    theme.bar.menus.menu.clock.weather.thermometer.hot           = org;
    theme.bar.menus.menu.clock.weather.thermometer.extremelyhot  = red;

    theme.bar.menus.menu.clock.calendar.contextdays = sep;
    theme.bar.menus.menu.clock.calendar.days        = fg2;
    theme.bar.menus.menu.clock.calendar.currentday  = mag;
    theme.bar.menus.menu.clock.calendar.paginator   = mag;
    theme.bar.menus.menu.clock.calendar.weekdays    = mag;
    theme.bar.menus.menu.clock.calendar.yearmonth   = cyn;

    # ---- per-menu: battery ----
    theme.bar.menus.menu.battery.background.color = bg0;
    theme.bar.menus.menu.battery.card.color       = bg2;
    theme.bar.menus.menu.battery.border.color     = brd;
    theme.bar.menus.menu.battery.label.color      = yel;
    theme.bar.menus.menu.battery.text             = fg2;
    theme.bar.menus.menu.battery.listitems.active  = yel;
    theme.bar.menus.menu.battery.listitems.passive = fg2;
    theme.bar.menus.menu.battery.icons.active  = yel;
    theme.bar.menus.menu.battery.icons.passive = sep;
    theme.bar.menus.menu.battery.slider.primary         = yel;
    theme.bar.menus.menu.battery.slider.background      = sep;
    theme.bar.menus.menu.battery.slider.backgroundhover = sep;
    theme.bar.menus.menu.battery.slider.puck            = sep;

    # ---- per-menu: volume ----
    theme.bar.menus.menu.volume.background.color = bg0;
    theme.bar.menus.menu.volume.card.color       = bg2;
    theme.bar.menus.menu.volume.border.color     = brd;
    theme.bar.menus.menu.volume.label.color      = red;
    theme.bar.menus.menu.volume.text             = fg2;

    theme.bar.menus.menu.volume.audio_slider.primary         = red;
    theme.bar.menus.menu.volume.audio_slider.background      = sep;
    theme.bar.menus.menu.volume.audio_slider.backgroundhover = sep;
    theme.bar.menus.menu.volume.audio_slider.puck            = sep;

    theme.bar.menus.menu.volume.input_slider.primary         = red;
    theme.bar.menus.menu.volume.input_slider.background      = sep;
    theme.bar.menus.menu.volume.input_slider.backgroundhover = sep;
    theme.bar.menus.menu.volume.input_slider.puck            = sep;

    theme.bar.menus.menu.volume.icons.active   = red;
    theme.bar.menus.menu.volume.icons.passive  = sep;
    theme.bar.menus.menu.volume.iconbutton.active  = red;
    theme.bar.menus.menu.volume.iconbutton.passive = fg2;
    theme.bar.menus.menu.volume.listitems.active   = red;
    theme.bar.menus.menu.volume.listitems.passive  = fg2;

    # ---- per-menu: media ----
    theme.bar.menus.menu.media.background.color = bg0;
    theme.bar.menus.menu.media.card.color       = bg2;
    theme.bar.menus.menu.media.border.color     = brd;
    theme.bar.menus.menu.media.album = mag;
    theme.bar.menus.menu.media.artist = cyn;
    theme.bar.menus.menu.media.song  = mag;
    theme.bar.menus.menu.media.slider.primary         = mag;
    theme.bar.menus.menu.media.slider.background      = sep;
    theme.bar.menus.menu.media.slider.backgroundhover = sep;
    theme.bar.menus.menu.media.slider.puck            = sep;
    theme.bar.menus.menu.media.buttons.background = mag;
    theme.bar.menus.menu.media.buttons.text       = bg0;
    theme.bar.menus.menu.media.buttons.enabled    = cyn;
    theme.bar.menus.menu.media.buttons.inactive   = sep;
    theme.bar.menus.menu.media.timestamp          = fg2;

    # ---- per-menu: bluetooth ----
    theme.bar.menus.menu.bluetooth.background.color = bg0;
    theme.bar.menus.menu.bluetooth.card.color       = bg2;
    theme.bar.menus.menu.bluetooth.border.color     = brd;
    theme.bar.menus.menu.bluetooth.text             = fg2;
    theme.bar.menus.menu.bluetooth.label.color      = cyn;
    theme.bar.menus.menu.bluetooth.icons.active     = cyn;
    theme.bar.menus.menu.bluetooth.icons.passive    = sep;
    theme.bar.menus.menu.bluetooth.iconbutton.active  = cyn;
    theme.bar.menus.menu.bluetooth.iconbutton.passive = fg2;
    theme.bar.menus.menu.bluetooth.listitems.active  = cyn;
    theme.bar.menus.menu.bluetooth.listitems.passive = fg2;
    theme.bar.menus.menu.bluetooth.switch.enabled  = cyn;
    theme.bar.menus.menu.bluetooth.switch.disabled = brd;
    theme.bar.menus.menu.bluetooth.switch.puck     = sep;
    theme.bar.menus.menu.bluetooth.switch_divider  = sep;
    theme.bar.menus.menu.bluetooth.status          = sep;

    # ---- per-menu: network ----
    theme.bar.menus.menu.network.background.color = bg0;
    theme.bar.menus.menu.network.card.color       = bg2;
    theme.bar.menus.menu.network.border.color     = brd;
    theme.bar.menus.menu.network.text             = fg2;
    theme.bar.menus.menu.network.label.color      = mag;
    theme.bar.menus.menu.network.icons.active     = mag;
    theme.bar.menus.menu.network.icons.passive    = sep;
    theme.bar.menus.menu.network.iconbuttons.active  = mag;
    theme.bar.menus.menu.network.iconbuttons.passive = fg2;
    theme.bar.menus.menu.network.listitems.active  = mag;
    theme.bar.menus.menu.network.listitems.passive = fg2;
    theme.bar.menus.menu.network.status.color      = sep;
    theme.bar.menus.menu.network.scroller.color    = mag;
    theme.bar.menus.menu.network.switch.enabled  = mag;
    theme.bar.menus.menu.network.switch.disabled = brd;
    theme.bar.menus.menu.network.switch.puck     = sep;

    # ---- bar buttons (core) ----
    theme.bar.buttons.style = "default";
    theme.bar.buttons.background = bg2;
    theme.bar.buttons.hover      = sep;
    theme.bar.buttons.icon       = mag;
    theme.bar.buttons.text       = mag;
    theme.bar.buttons.borderColor = mag;

    # media
    theme.bar.buttons.media.icon       = bg2;
    theme.bar.buttons.media.text       = bg2;
    theme.bar.buttons.media.background = mag;
    theme.bar.buttons.media.border     = mag;
    theme.bar.buttons.media.icon_background = mag;

    # notifications
    theme.bar.buttons.notifications.total      = bg2;
    theme.bar.buttons.notifications.icon       = bg2;
    theme.bar.buttons.notifications.background = mag;
    theme.bar.buttons.notifications.border     = mag;
    theme.bar.buttons.notifications.icon_background = mag;

    # clock
    theme.bar.buttons.clock.icon        = bg2;
    theme.bar.buttons.clock.text        = bg2;
    theme.bar.buttons.clock.background  = mag;
    theme.bar.buttons.clock.border      = mag;
    theme.bar.buttons.clock.icon_background = mag;

    # battery
    theme.bar.buttons.battery.icon        = bg2;
    theme.bar.buttons.battery.text        = bg2;
    theme.bar.buttons.battery.background  = yel;
    theme.bar.buttons.battery.border      = yel;
    theme.bar.buttons.battery.icon_background = yel;

    # bluetooth
    theme.bar.buttons.bluetooth.icon        = bg2;
    theme.bar.buttons.bluetooth.text        = bg2;
    theme.bar.buttons.bluetooth.background  = cyn;
    theme.bar.buttons.bluetooth.border      = cyn;
    theme.bar.buttons.bluetooth.icon_background = cyn;

    # network
    theme.bar.buttons.network.icon        = bg2;
    theme.bar.buttons.network.text        = bg2;
    theme.bar.buttons.network.background  = mag;
    theme.bar.buttons.network.border      = mag;
    theme.bar.buttons.network.icon_background = mag;

    # volume
    theme.bar.buttons.volume.icon        = bg2;
    theme.bar.buttons.volume.text        = bg2;
    theme.bar.buttons.volume.background  = org;
    theme.bar.buttons.volume.border      = org;
    theme.bar.buttons.volume.icon_background = org;

    # window title
    theme.bar.buttons.windowtitle.icon           = bg2;
    theme.bar.buttons.windowtitle.text           = bg2;
    theme.bar.buttons.windowtitle.background     = mag;
    theme.bar.buttons.windowtitle.border         = mag;
    theme.bar.buttons.windowtitle.icon_background = mag;

    # workspaces
    theme.bar.buttons.workspaces.active     = mag;
    theme.bar.buttons.workspaces.occupied   = mag;
    theme.bar.buttons.workspaces.available  = cyn;
    theme.bar.buttons.workspaces.hover      = sep;
    theme.bar.buttons.workspaces.background = bg1;
    theme.bar.buttons.workspaces.border     = bg0;
    theme.bar.buttons.workspaces.numbered_active_highlighted_text_color = bg0;
    theme.bar.buttons.workspaces.numbered_active_underline_color        = mag;

    # dashboard button
    theme.bar.buttons.dashboard.border     = yel;
    theme.bar.buttons.dashboard.background = styles.base09;
    theme.bar.buttons.dashboard.icon       = bg2;

    # modules (grouped accents)
    theme.bar.buttons.modules.power = {
      background = red;  text = bg2;  icon = bg2;  border = red;  icon_background = red;
    };
    theme.bar.buttons.modules.weather = {
      background = mag;  text = bg2;  icon = bg2;  border = mag;  icon_background = mag;
    };
    theme.bar.buttons.modules.updates = {
      background = mag;  text = bg2;  icon = bg2;  border = mag;  icon_background = mag;
    };
    theme.bar.buttons.modules.kbLayout = {
      background = cyn;  text = bg2;  icon = bg2;  border = cyn;  icon_background = cyn;
    };
    theme.bar.buttons.modules.netstat = {
      background = grn;  text = bg2;  icon = bg2;  border = grn;  icon_background = grn;
    };
    theme.bar.buttons.modules.storage = {
      background = red;  text = bg2;  icon = bg2;  border = red;  icon_background = red;
    };
    theme.bar.buttons.modules.cpu = {
      background = red;  text = bg2;  icon = bg2;  border = red;  icon_background = red;
    };
    theme.bar.buttons.modules.ram = {
      background = yel;  text = bg2;  icon = bg2;  border = yel;  icon_background = yel;
    };
    theme.bar.buttons.modules.hyprsunset = {
      background = red;  text = bg2;  icon = bg2;  border = red;  icon_background = red;
    };
    theme.bar.buttons.modules.hypridle = {
      background = red;  text = bg2;  icon = bg2;  border = red;  icon_background = red;
    };
    theme.bar.buttons.modules.cava = {
      background = cyn;  text = bg2;  icon = bg2;  border = cyn;  icon_background = bg2;
    };
    theme.bar.buttons.modules.microphone = {
      background = grn;  text = bg2;  icon = bg2;  border = grn;  icon_background = grn;
    };
    theme.bar.buttons.modules.worldclock = {
      background = mag;  text = bg2;  icon = bg2;  border = mag;  icon_background = mag;
    };

    # systray
    theme.bar.buttons.systray.background = bg2;
    theme.bar.buttons.systray.border     = sep;
    theme.bar.buttons.systray.customIcon = fg2;

    # border/edge
    theme.bar.border.color = mag;
    theme.bar.buttons.icon_background = bg2;

    # ---- OSD ----
    theme.osd.label          = mag;
    theme.osd.icon           = bg0;
    theme.osd.bar_overflow_color = red;
    theme.osd.bar_empty_color    = brd;
    theme.osd.bar_color          = mag;
    theme.osd.icon_container     = mag;
    theme.osd.bar_container      = bg0;

    # ---- notifications ----
    theme.notification.background         = bg0;
    theme.notification.border             = brd;
    theme.notification.text               = fg2;
    theme.notification.time               = sep;
    theme.notification.label              = mag;
    theme.notification.labelicon          = mag;
    theme.notification.actions.text       = bg0;
    theme.notification.actions.background = mag;
    theme.notification.close_button.background = red;
    theme.notification.close_button.label      = bg0;

    # ---- extra palette aliases (if referenced by your build) ----
    bg = bg0;
    bg_dark = bg0;
    bg_dark1 = bg0;
    bg_highlight = bg2;
    blue = blu; blue0 = blu; blue1 = cyn; blue2 = cyn; blue5 = blu; blue6 = blu; blue7 = blu;
    comment = sep;
    cyan = cyn;
    dark3 = sep;
    dark5 = sep;
    fg = fg2;
    fg_dark = fg;
    fg_gutter = sep;
    green = grn; green1 = cyn; green2 = cyn;
    magenta = mag; magenta2 = mag;
    orange = org;
    purple = mag;
    red = red; red1 = red;
    teal = cyn;
    terminal_black = sep;
    yellow = yel;
  };
}
