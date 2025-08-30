{
  config,
  lib,
  ...
}: let
  # Widget namespace shortcuts
  plasma = "org.kde.plasma";
  kde = "org.kde";
  
  # Common widget names
  widgets = {
    kickoff = "${plasma}.kickoff";
    pager = "${plasma}.pager";
    taskmanager = "${plasma}.taskmanager";
    separator = "${plasma}.marginsseparator";
    systemtray = "${plasma}.systemtray";
    clock = "${plasma}.digitalclock";
    showdesktop = "${plasma}.showdesktop";
    
    # System tray applets
    tray = {
      mediacontroller = "${plasma}.mediacontroller";
      notifications = "${plasma}.notifications";
      inputmethod = "${plasma}.manage-inputmethod";
      camera = "${plasma}.cameraindicator";
      devicenotifier = "${plasma}.devicenotifier";
      clipboard = "${plasma}.clipboard";
      kdeconnect = "${kde}.kdeconnect";
      battery = "${plasma}.battery";
      kscreen = "${kde}.kscreen";
      bluetooth = "${plasma}.bluetooth";
      network = "${plasma}.networkmanagement";
      volume = "${plasma}.volume";
      keyboard = "${plasma}.keyboardlayout";
      brightness = "${plasma}.brightness";
      keyboardindicator = "${plasma}.keyboardindicator";
    };
  };
  
  # System tray items list
  trayItems = with widgets.tray; [
    mediacontroller notifications inputmethod camera devicenotifier
    clipboard kdeconnect battery kscreen bluetooth network volume
    keyboard brightness keyboardindicator
  ];
  trayItemsString = lib.concatStringsSep "," trayItems;
  
in {
  config = lib.mkIf config.wms.plasma.enable {
    programs.plasma.panels = [
      # Single panel for all monitors
      {
        location = "bottom";
        height = 44;
        lengthMode = "fill";
        alignment = "center";
        screen = "all";  # Apply to all screens
        widgets = [
          {
            name = widgets.kickoff;
            config = {
              General = {
                icon = "nix-snowflake-white";
                favoritesPortedToKAstats = true;
                systemFavorites = "suspend\\,hibernate\\,reboot\\,shutdown";
              };
            };
          }
          {
            name = widgets.pager;
            config = {
              General = {
                showOnlyCurrentScreen = true;
                showWindowIcons = true;
              };
            };
          }
          {
            name = widgets.taskmanager;
            config = {
              General = {
                launchers = "applications:systemsettings.desktop,preferred://filemanager";
                showOnlyCurrentScreen = true;
                taskMaxWidth = "Narrow";
                groupingStrategy = 0;
              };
            };
          }
          widgets.separator
          {
            name = widgets.systemtray;
            config = {
              General = {
                extraItems = trayItemsString;
                knownItems = trayItemsString;
              };
            };
          }
          {
            name = widgets.clock;
            config = {
              Appearance = {
                fontWeight = 400;
              };
            };
          }
          widgets.showdesktop
        ];
      }
    ];
  };
}
