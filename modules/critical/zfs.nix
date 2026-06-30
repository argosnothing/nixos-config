### ZFS
# The only filesystem I use and the only filesystem that matters...
# https://github.com/iynaix/dotfiles/blob/978cc85a40fc298ac9163d893a4cf37725bf45de/modules/zfs.nix#L4
{config, ...}: let
  inherit (config.flake) settings;
in {
  flake.modules.nixos.zfs = {
    config,
    lib,
    ...
  }: {
    boot = {
      supportedFilesystems = ["zfs"];
      initrd.supportedFilesystems = ["zfs"];
      zfs.devNodes =
        "/dev/disk/"
        + (
          if config.my.is-vm
          then "by-partuuid"
          else "by-id"
        );
    };
    fileSystems = {
      "/" = {
        device = "zroot/root";
        fsType = "zfs";
        neededForBoot = true;
      };

      # boot partition
      "/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };

      "/nix" = {
        device = "zroot/nix";
        fsType = "zfs";
        neededForBoot = true;
      };

    };
    systemd.services = {
      # https://github.com/openzfs/zfs/issues/10891
      systemd-udev-settle.enable = false;
    };

    boot.extraModprobeConfig = lib.mkIf (config.my.zfs.arcMax != null) ''
      options zfs zfs_arc_max=${toString config.my.zfs.arcMax}
    '';

    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 25;
    };

    networking.hostId = settings.networking.hostId;
    services = {
      zfs.autoScrub.enable = true;
      zfs.trim.enable = true;
    };
  };
}
