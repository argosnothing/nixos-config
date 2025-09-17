{settings, ...}: {
  imports = [
    ./cosmic
    ./hyprland
    ./niri
    ./gnome
  ];
  wms.${settings.wm}.enable = true;
}
