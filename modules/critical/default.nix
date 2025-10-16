{firmware, ...}: {
  imports = [
    ./grub.nix
    ./uefi.nix
    ./zfs.nix
    ./sops.nix
    ./user.nix
  ];
  config = {
    my.modules.critical.${firmware}.enable = true;
  };
}
