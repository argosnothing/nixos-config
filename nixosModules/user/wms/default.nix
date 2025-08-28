{settings, ...}: {
  imports = [
    (./. + "/${settings.wm}")
  ];
  wms.${settings.wm}.enable = true;
}
