{
  config,
  settings,
  lib,
  ...
}: {
  options = {
    zfs.enable = lib.mkEnableOption "Enable Zfs";
  };
  config = lib.mkIf config.zfs.enable {
    boot.supportedFilesystems = ["zfs"];
    boot.initrd.supportedFilesystems = ["zfs"];
    boot.zfs.devNodes = settings.zfs.devNodes;
    networking.hostId = settings.zfs.hostId;
    services.zfs.autoScrub.enable = true;
    services.zfs.trim.enable = true;
    users = {
      groups.sanoid = {};
      users.sanoid = {
        isSystemUser = true;
        group = "sanoid";
      };
    };
    services.sanoid = {
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
}
