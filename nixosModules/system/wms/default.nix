{
  settings,
  ...
}: {
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./niri.nix
  ];
  wms."${settings.wm}".enable = true;
}
