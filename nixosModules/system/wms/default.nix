{settings, ...}: {
  imports = [
    ./cosmic.nix
    ##./gnome.nix
    ./hyprland.nix
  ];
  wms."${settings.wm}".enable = true;
}
