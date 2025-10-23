{config, ...}: {
  flake.modules.nixos.critical = let
    inherit (config) settings;
  in {
    boot = {
      supportedFilesystems = ["zfs"];
      initrd.supportedFilesystems = ["zfs"];
      zfs.devNodes =
        "/dev/disk/"
        + (
          if settings.isVm
          then "by-partuuid"
          else "by-id"
        );
    };
    networking.hostId = settings.hostId;
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
