### UEFI Firmware
# I had a grub one somewhere, where did i put it...
{
  flake.modules.nixos.uefi = {
    boot = {
      loader = {
        grub.enable = false;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
