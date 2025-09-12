{pkgs, settings, ...}: {
  imports = [];
  environment.systemPackages = with pkgs; [git vim];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.initrd.supportedFilesystems = ["zfs"];
  boot.zfs.devNodes = "/dev/disk/by-partuuid";
  networking.hostId = "deadbeef"; # generate with `openssl rand -hex 4`
  users.users."${settings.username}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
  };

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  system.stateVersion = "25.05";
}
