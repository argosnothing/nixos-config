{
  flake.modules.nixos.gnome = {pkgs, ...}: {
    my.cursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    my.persist = {
      home.files = [
        ".config/gnome-official-setup-done"
      ];
      home.directories = [
        ".local/share/gnome-shell"
      ];
    };
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
