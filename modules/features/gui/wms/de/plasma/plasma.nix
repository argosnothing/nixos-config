{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.plasma = {
    imports = with flake.modules.nixos; [
      cursor
    ];

    my.persist = {
      root = {
        files = [
          "/var/lib/sddm/state.conf"
        ];
      };
      home = {
        directories = [
          ".local/share/baloo"
          ".local/share/klipper"
          ".local/share/kwalletd"
          ".config/kdedefaults"
        ];
        cache.directories = [
          ".cache/plasmashell"
        ];
        files = [
          ".config/dolphinrc"
          ".config/gtkrc"
          ".config/baloofilerc"
          ".config/kactivitymanagerd-statsrc"
          ".config/kded5rc"
          ".config/kdeglobals"
          ".config/kglobalshortcutsrc"
          ".config/konsolerc"
          ".config/konsolesshconfig"
          ".config/ktimezonedrc"
          ".config/kwalletrc"
          ".config/kwinoutputconfig.json"
          ".config/kwinrc"
          ".config/plasma-localerc"
          ".config/plasma-org.kde.plasma.desktop-appletrc"
          ".config/plasmashellrc"
          ".config/powermanagementprofilesrc"
          ".config/Trolltech.conf"
          ".config/user-dirs.dirs"
          ".config/user-dirs.locale"
          ".config/kcminputrc"
        ];
      };
    };

    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      desktopManager = {
        plasma6.enable = true;
      };
    };
  };
}
