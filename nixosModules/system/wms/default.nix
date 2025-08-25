{
  settings,
  ...
}: {
  imports = [
    ./gnome.nix
    ./hyprland.nix
  ];
  wms."${settings.wm}".enable = true;
}
