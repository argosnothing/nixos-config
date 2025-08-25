{config, lib, pkgs, ...}: {
  imports = [
    ./apps
    ./misc
    ./services
    ./wms
    ./style
  ];
}