{
  flake.modules.nixos.critical = {
    boot = {
      loader = {
        grub.enable = false;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
