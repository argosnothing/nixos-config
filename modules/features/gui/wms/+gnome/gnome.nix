{
  flake.modules.nixos.gnome = {pkgs, ...}: {
    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            enable-animations = false;
          };
        };
      }
    ];
    my.cursor = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 15;
    };
    quantum.entangle-folders = {
      "gnome/.config/gtk-3.0" = ".config/gtk-3.0";
      "gnome/.config/gtk-4.0" = ".config/gtk-4.0";
      "gnome/.config/paperwm" = ".config/paperwm";
    };
    my.persist = {
      home.directories = [
        ".local/share/gnome-shell"
      ];
      home.cache.directories = [".cache/thumbnails"];
      home.files = [
        ".config/monitors.xml"
      ];
    };
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
