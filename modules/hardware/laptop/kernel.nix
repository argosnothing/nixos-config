{
  flake.modules.nixos.laptop = {
    boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "rtsx_pci_sdmmc"];
  };
}
