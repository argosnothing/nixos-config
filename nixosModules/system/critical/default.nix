{settings, ...}: {
  imports = [
    ./grub.nix
    ./uefi.nix
    ./zfs.nix
    ./sops.nix
  ];

  "${settings.boot.firmware}".enable = true;
}
