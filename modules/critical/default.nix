{settings, ...}: {
  imports = [
    ./grub.nix
    ./uefi.nix
    ./zfs.nix
    ./sops.nix
  ];

  my.modules.critical."${settings.boot.firmware}".enable = true;
}
