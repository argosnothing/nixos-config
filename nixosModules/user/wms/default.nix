{settings, ...}: {
  imports = [ 
    ./hyprland
    ./gnome
  ];
  wms.${settings.wm}.enable = true;
}