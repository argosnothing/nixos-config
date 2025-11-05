{
  flake.modules.nixos.p51 = {config, ...}: {
    # P51-specific NVIDIA Quadro M2200 Mobile configuration
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    # Accept NVIDIA license
    nixpkgs.config.nvidia.acceptLicense = true;

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false; # Quadro M2200 requires proprietary driver
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470; # Use legacy driver for Maxwell GPUs
    };
  };
}
