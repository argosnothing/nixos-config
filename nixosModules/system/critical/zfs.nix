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
    services.zfs.autoSnapshot.enable = true;
    services.zfs.autoScrub.enable = true;
    services.zfs.trim.enable = true;
  };
}
