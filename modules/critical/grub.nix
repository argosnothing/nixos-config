{
  flake.modules.nixos.grub = {
    boot = {
      loader = {
        grub.enable = true;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
