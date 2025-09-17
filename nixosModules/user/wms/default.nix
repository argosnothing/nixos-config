{settings, ...}: {
  imports = [
    ./cosmic
    ./hyprland
    ./niri
  ];
  wms.${settings.wm}.enable = true;
}
