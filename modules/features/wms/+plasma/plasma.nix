{
  flake.modules.nixos.plasma = {pkgs, ...}: {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    my.persist = {
      home.files = [
        ".config/plasma-org.kde.plasma.desktop-appletsrc"
        ".config/plasmashellrc"
        ".config/plasmarc"
        ".config/kwinrc"
        ".config/kwinrulesrc"
        ".config/kdeglobals"
        ".config/kglobalshortcutsrc"
        ".config/khotkeysrc"
        ".config/ksmserverrc"
        ".config/kscreenlockerrc"
        ".config/ksplashrc"
        ".config/klaunchrc"
        ".config/Trolltech.conf"
        ".config/breezerc"
        ".config/kcmfonts"
        ".config/kcminputrc"
        ".config/plasma-localerc"
        ".config/kconf_updaterc"
        ".config/kactivitymanagerdrc"
        ".config/kactivitymanagerd-pluginsrc"
        ".config/kactivitymanagerd-switcher"
        ".config/kactivitymanagerd-statsrc"
        ".config/dolphinrc"
        ".config/konsolerc"
        ".config/krunnerrc"
        ".config/klipperrc"
        ".config/powerdevilrc"
        ".config/baloofilerc"
        ".config/baloofileinformationrc"
        ".config/kdeconnectrc"
        ".config/bluedevilglobalrc"
        ".config/spectaclerc"
        ".config/systemsettingsrc"
        ".config/katerc"
        ".config/kateschemarc"
        ".config/kiorc"
        ".config/kmenueditrc"
        ".config/filetypesrc"
        ".config/kservicemenurc"
        ".config/knotifyrc"
        ".config/kded_device_automounterrc"
        ".config/device_automounter_kcmrc"
        ".config/ktimezonedrc"
        ".config/kaccessrc"
        ".config/kcmdisplayrc"
        ".config/kgammarc"
        ".config/kmixrc"
        ".config/kdebugrc"
        ".config/kwinoutputconfig.json"
        ".config/powermanagementprofilesrc"
        ".config/kded5rc"
        ".local/share/recently-used.xbel"
        ".local/share/user-places.xbel"
        ".local/state/kickerstaterc"
        ".local/state/konsolestaterc"
        ".local/state/kactivitymanagerdstaterc"
      ];

      home.directories = [
        ".config/kdeconnect"
        ".config/kdedefaults"
        ".config/gtk-3.0"
        ".config/gtk-4.0"
        ".config/xsettingsd"
        ".config/KDE"
        ".config/kde.org"
        ".config/plasma-workspace"
        ".local/share/kscreen"
        ".local/share/kwalletd"
        ".local/share/kactivitymanagerd"
        ".local/share/baloo"
        ".local/share/dolphin"
        ".local/share/konsole"
        ".local/share/kxmlgui5"
        ".local/share/kxmlgui6"
        ".local/share/klipper"
        ".local/share/kate"
        ".local/share/RecentDocuments"
        ".local/share/fonts"
        ".local/state/kwin"
        ".local/state/plasmashell"
        ".icons"
      ];

      home.cache.directories = [
        ".cache/kwin"
        ".cache/plasma"
        ".cache/plasma-svgelements"
        ".cache/plasmashell"
        ".cache/ksplash"
        ".cache/kio"
        ".cache/ksvg"
        ".cache/thumbnails"
        ".cache/baloo"
        ".cache/qtshadercache-x86_64-little_endian-lp64"
        # ".cache/fontconfig"
        ".cache/mesa_shader_cache"
      ];

      home.cache.files = [];

      root.directories = [
        "/var/lib/sddm"
        "/var/lib/AccountsService"
      ];
    };
  };
}
