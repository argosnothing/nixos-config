{pkgs, pkgsUnstable, config, ...}: let 
    nvidiaPackage = pkgsUnstable.linuxPackages_xanmod_latest.nvidiaPackages.latest;
in {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = nvidiaPackage;
  };
}