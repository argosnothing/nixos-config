{
  flake.modules.nixos.grub = {
    boot = {
      loader = {
        grub.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
