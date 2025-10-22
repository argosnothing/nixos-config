{
  config,
  settings,
  lib,
  ...
}: {
  options.my.modules.critical = {
    zfs.enable = lib.mkEnableOption "Enable Zfs";
  };
  config = lib.mkIf config.my.modules.critical.zfs.enable {
    boot = {
      supportedFilesystems = ["zfs"];
      initrd.supportedFilesystems = ["zfs"];
      zfs.devNodes = settings.zfs.devNodes;
    };
    networking.hostId = settings.zfs.hostId;
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
