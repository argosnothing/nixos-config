{pkgsUnstable, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true; # Revert back to open source driver
    nvidiaSettings = true;
    package = pkgsUnstable.linuxPackages.nvidiaPackages.latest;
  };
}