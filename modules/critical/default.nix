{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum;
  inherit (config.my.modules.critical) firmware;
in {
  imports = [
    ./grub.nix
    ./uefi.nix
    ./zfs.nix
    ./sops.nix
    ./user.nix
  ];
  options = {
    my.modules.critical.firmware = mkOption {
      description = "Firmware choice, set in host config";
      type = enum ["uefi" "bios"];
    };
  };
  config = {
    my.modules.critical.${firmware}.enable = true;
  };
}
