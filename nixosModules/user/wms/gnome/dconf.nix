# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{
  lib,
  settings,
  ...
}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/Console" = {
      last-window-maximised = false;
      last-window-size = mkTuple [812 528];
    };

    "org/gnome/Extensions" = {
      window-height = 1228;
      window-maximized = false;
      window-width = 1921;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = ["X-SuSE-YaST"];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [(mkTuple ["xkb" "us"])];
      xkb-options = ["terminate:ctrl_alt_bksp"];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-size = 32;
      cursor-theme = "Adwaita";
      document-font-name = "Liberation Serif  11";
      enable-animations = true;
      font-name = "Noto Sans,  10";
      gtk-enable-primary-paste = false;
      gtk-theme = "Adwaita";
      icon-theme = "Adwaita";
      locate-pointer = false;
      monospace-font-name = "FiraCode Nerd Font 12";
      scaling-factor = mkUint32 1;
      text-scaling-factor = 1.25;
      toolbar-style = "text";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = ["org.gnome.Settings.desktop" "org.gnome.Contacts.desktop" "org.gnome.Nautilus.desktop"];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "icon:minimize,maximize,close";
      num-workspaces = 8;
    };

    "org/gnome/eog/view" = {
      background-color = "#1d2021";
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/epiphany/state" = {
      is-maximized = false;
      window-size = mkTuple [1024 768];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/gnome-system-monitor" = {
      cpu-colors = [(mkTuple [(mkUint32 0) "#e01b24"]) (mkTuple [1 "#ff7800"]) (mkTuple [2 "#f6d32d"]) (mkTuple [3 "#33d17a"]) (mkTuple [4 "#26a269"]) (mkTuple [5 "#62a0ea"]) (mkTuple [6 "#1c71d8"]) (mkTuple [7 "#613583"]) (mkTuple [8 "#9141ac"]) (mkTuple [9 "#c061cb"]) (mkTuple [10 "#ffbe6f"]) (mkTuple [11 "#f9f06b"]) (mkTuple [12 "#8ff0a4"]) (mkTuple [13 "#2ec27e"]) (mkTuple [14 "#1a5fb4"]) (mkTuple [15 "#c061cb"]) (mkTuple [16 "#7999f332e08a"]) (mkTuple [17 "#f332bd0f7999"]) (mkTuple [18 "#99947999f332"]) (mkTuple [19 "#7d19f3327999"]) (mkTuple [20 "#f3327999a094"]) (mkTuple [21 "#7999c410f332"]) (mkTuple [22 "#e78bf3327999"]) (mkTuple [23 "#db5d7999f332"])];
      current-tab = "processes";
      maximized = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-height = 720;
      window-width = 800;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      col-26-visible = false;
      col-26-width = 0;
    };

    "org/gnome/maps" = {
      last-viewed-location = [0.0 0.0];
      map-type = "MapsVectorSource";
      transportation-type = "pedestrian";
      window-maximized = true;
      window-size = [1014 420];
      zoom-level = 2;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      experimental-features = ["scale-monitor-framebuffer"];
      output-luminance = [(mkTuple ["DP-1" "AUS" "XG27UCS" "S7LMTF022811" (mkUint32 1) 190.0])];
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [890 550];
      initial-size-file-chooser = mkTuple [1578 1286];
    };

    "org/gnome/portal/filechooser/org/gnome/Settings" = {
      last-folder-path = "/home/${settings.username}/.local/share/wallpapers";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;
      night-light-schedule-automatic = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>Return";
      command = "guake-toggle";
      name = "Guake";
    };

    "org/gnome/shell" = {
      disabled-extensions = ["just-perfection-desktop@just-perfection" "window-title-is-back@fthx" "task-up@fthx" "gSnap@micahosborne" "unmess@ezix.org" "yaru-like-panel@fthx" "dash-in-panel@fthx" "task-up-ultralite@fthx" "alt-tab-current-monitor@esauvisky.github.io"];
      enabled-extensions = ["extension-list@tu.berry" "top-bar-organizer@julian.gse.jsts.xyz" "unite@hardpixel.eu" "gnomeGlobalAppMenu@lestcape" "user-theme@gnome-shell-extensions.gcampax.github.com" "gsconnect@andyholmes.github.io" "advanced-alt-tab@G-dH.github.com" "dash-to-panel@jderose9.github.com"];
      favorite-apps = [];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "48.2";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/advanced-alt-tab-window-switcher" = {
      app-switcher-popup-filter = 3;
      hot-edge-mode = 0;
      switcher-popup-monitor = 3;
      win-switcher-popup-filter = 3;
    };

    "org/gnome/shell/extensions/dash-in-panel" = {
      move-date = false;
      show-dash = false;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover = true;
      appicon-style = "NORMAL";
      dot-position = "BOTTOM";
      dot-style-focused = "SQUARES";
      dot-style-unfocused = "DOTS";
      extension-version = 68;
      global-border-radius = 1;
      group-apps = false;
      highlight-appicon-hover = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      intellihide = false;
      isolate-monitors = true;
      isolate-workspaces = true;
      overview-click-to-exit = false;
      prefs-opened = false;
      show-apps-icon-file = "";
      show-apps-icon-side-padding = 8;
      show-apps-override-escape = true;
      stockgs-force-hotcorner = false;
      stockgs-keep-dash = false;
      stockgs-keep-top-panel = false;
      stockgs-panelbtn-click-only = false;
      trans-bg-color = "#986a44";
      trans-gradient-bottom-color = "#dc8add";
      trans-use-custom-bg = false;
      trans-use-custom-gradient = false;
      trans-use-custom-opacity = false;
      window-preview-title-position = "TOP";
    };

    "org/gnome/shell/extensions/extension-list" = {
      enable-filter = true;
    };

    "org/gnome/shell/extensions/gsconnect" = {
      keep-alive-when-locked = true;
      name = "${settings.hostname}";
      show-indicators = true;
    };

    "org/gnome/shell/extensions/gsconnect/preferences" = {
      window-maximized = false;
      window-size = mkTuple [660 460];
    };

    "org/gnome/shell/extensions/gsnap" = {
      animations-enabled = false;
      show-tabs = false;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = true;
      background-menu = true;
      controls-manager-spacing-size = 0;
      dash = true;
      dash-icon-size = 0;
      double-super-to-appgrid = true;
      osd = true;
      panel = true;
      panel-in-overview = true;
      ripple-box = true;
      search = true;
      show-apps-button = true;
      startup-status = 1;
      support-notifier-type = 0;
      theme = false;
      window-demands-attention-focus = false;
      window-picker-icon = true;
      window-preview-caption = true;
      window-preview-close-button = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-popup = true;
      workspaces-in-app-grid = true;
    };

    "org/gnome/shell/extensions/top-bar-organizer" = {
      center-box-order = ["dateMenu"];
      left-box-order = ["activities"];
      right-box-order = ["extension-list@tu.berry" "screenRecording" "screenSharing" "dwellClick" "a11y" "keyboard" "quickSettings"];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "";
    };

    "org/gnome/shell/extensions/window-title-is-back" = {
      colored-icon = false;
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/software" = {
      check-timestamp = mkInt64 1756584715;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1756609150;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/color-chooser" = {
      selected-color = mkTuple [true 0.8627451062202454 0.5411764979362488 0.8666666746139526 1.0];
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 187;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [26 23];
      window-size = mkTuple [1724 1272];
    };

    "org/guake/general" = {
      compat-delete = "delete-sequence";
      default-shell = "/run/current-system/sw/bin/zsh";
      display-n = 0;
      display-tab-names = 0;
      gtk-use-system-default-theme = true;
      hide-tabs-if-one-tab = false;
      history-size = 1000;
      load-guake-yml = true;
      max-tab-name-length = 100;
      mouse-display = true;
      open-tab-cwd = true;
      prompt-on-quit = true;
      quick-open-command-line = "gedit %(file_path)s";
      restore-tabs-notify = true;
      restore-tabs-startup = true;
      save-tabs-when-changed = true;
      schema-version = "3.10";
      scroll-keystroke = true;
      use-default-font = true;
      use-popup = true;
      use-scrollbar = true;
      use-trayicon = true;
      window-halignment = 0;
      window-height = 50;
      window-losefocus = false;
      window-refocus = false;
      window-tabbar = true;
      window-width = 100;
    };

    "org/guake/keybindings/global" = {
      show-hide = "<Primary><Shift>x";
    };

    "org/guake/style/background" = {
      transparency = 90;
    };
  };
}
