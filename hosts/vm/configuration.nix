{...}: {
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
  ];
  my.modules.critical.zfs.enable = true;
  my.persist.enable = true;
}
