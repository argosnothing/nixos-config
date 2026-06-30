{
  flake.modules.nixos.lightdm = {...}: {
    services.xserver.displayManager.lightdm.enable = true;
  };
}
