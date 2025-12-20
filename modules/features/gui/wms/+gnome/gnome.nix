{
  flake.modules.nixos.gnome = {pkgs, ...}: {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
