{
  flake.modules.nixos.laptop = {
    lib,
    config,
    pkgs,
    ...
  }: {
    boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];
    swapDevices = [];
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware = {
      enableAllFirmware = true;
      firmware = [pkgs.linux-firmware];
    };
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
