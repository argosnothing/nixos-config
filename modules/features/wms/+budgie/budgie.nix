{
  flake.modules.nixos.budgie = {pkgs, ...}: {
    services = {
      xserver = {
        enable = true;
        desktopManager.budgie.enable = true;
        displayManager.lightdm.enable = true;
      };
    };
  };
}
