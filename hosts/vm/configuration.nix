{...}: {
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
  ];
  zfs.enable = true;
  custom.persist.enable = true;
  custom.apps.yazi.enable = true;
}
