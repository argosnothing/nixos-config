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
