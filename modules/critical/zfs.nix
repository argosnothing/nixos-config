# https://github.com/iynaix/dotfiles/blob/978cc85a40fc298ac9163d893a4cf37725bf45de/modules/zfs.nix#L4
{config, ...}: let
  inherit (config.flake) settings;
in {
  flake.modules.nixos.zfs = {config, ...}: {
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
      # NOTE: root and home are on tmpfs
      # root partition, exists only as a fallback, actual root is a tmpfs
      "/" = {
        device = "zroot/root";
        fsType = "zfs";
        neededForBoot = true;
      };

      # uncomment to use separate home dataset
      # "/home" = {
      #   device = "zroot/home";
      #   fsType = "zfs";
      #   neededForBoot = true;
      # };

      # boot partition
      "/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };

      "/nix" = {
        device = "zroot/nix";
        fsType = "zfs";
      };

      # by default, /tmp is not a tmpfs on nixos as some build artifacts can be stored there
      # when using / as a small tmpfs for impermanence, /tmp can then easily run out of space,
      # so create a dataset for /tmp to prevent this
      # /tmp is cleared on boot via `boot.tmp.cleanOnBoot = true;`
      "/tmp" = {
        device = "zroot/tmp";
        fsType = "zfs";
      };

      "/persist" = {
        device = "zroot/persist";
        fsType = "zfs";
        neededForBoot = true;
      };

      # cache are files that should be persisted, but not to snapshot
      # e.g. npm, cargo cache etc, that could always be redownloaded
      "/cache" = {
        device = "zroot/cache";
        fsType = "zfs";
        neededForBoot = true;
      };
    };
    systemd.services = {
      # https://github.com/openzfs/zfs/issues/10891
      systemd-udev-settle.enable = false;
    };

    networking.hostId = settings.networking.hostId;
    services = {
      zfs.autoScrub.enable = true;
      zfs.trim.enable = true;
      sanoid = {
        enable = true;

        templates.default = {
          autosnap = true;
          autoprune = true;
          daily = 7;
          weekly = 4;
        };

        datasets = {
          "zroot/persist" = {
            useTemplate = ["default"];
            recursive = true;
          };
        };
      };
    };
    users = {
      groups.sanoid = {};
      users.sanoid = {
        isSystemUser = true;
        group = "sanoid";
      };
    };
  };
}
