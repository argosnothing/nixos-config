{...}: {
  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
    ../../nixosModules/system
  ];
  zfs.enable = true;
}
