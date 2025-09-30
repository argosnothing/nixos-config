{...}: {
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
    ../../nixosModules/system
  ];
  zfs.enable = true;
  custom.apps.yazi.enable = true;
}
