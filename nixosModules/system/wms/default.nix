{settings, ...}: {
  imports = [
    (./. + "/${settings.wm}.nix")
  ];
  wms."${settings.wm}".enable = true;
}
