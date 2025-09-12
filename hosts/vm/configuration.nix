{pkgs, settings, ...}: {
  imports = [];
  environment.systemPackages = with pkgs; [git vim];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.initrd.supportedFilesystems = ["zfs"];
  boot.zfs.devNodes = "/dev/disk/by-partuuid";
  networking.hostId = "openssl rand -hex 4"; # put contents of that command here

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
}
