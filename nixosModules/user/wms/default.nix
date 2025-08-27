{settings, ...}: {
  imports = [ 
    ./hyprland
    ./gnome
    ./niri
  ];
  wms.${settings.wm}.enable = true;
}
