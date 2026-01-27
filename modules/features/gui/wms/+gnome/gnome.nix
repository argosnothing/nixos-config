{
  flake.modules.nixos.gnome = {pkgs, ...}: {
    my.cursor = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 15;
    };
    quantum.entangle-folders = {
      "gnome/.config/gtk-3.0" = ".config/gtk-3.0";
      "gnome/.config/gtk-4.0" = ".config/gtk-4.0";
    };
    my.persist = {
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
