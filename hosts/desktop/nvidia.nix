{inputs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true; # Revert back to open source driver
    nvidiaSettings = true;
    package = inputs.pkgsUnstable.linuxPackages.nvidiaPackages.latest;
  };
}