{
  flake.modules.nixos.gnome = {pkgs, ...}: {
    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            enable-animations = true;
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
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
