{pkgs, pkgsUnstable, config, ...}: let 
    nvidiaPackage = pkgsUnstable.linuxPackages.nvidiaPackages.beta;
in {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = nvidiaPackage;
  };
}