{
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../configuration.nix
    ./hardware-configuration.nix
    ../../nixosModules/system
  ];
  zfs.enable = true;
}
