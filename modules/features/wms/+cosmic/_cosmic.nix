{
  flake.modules.nixos.cosmic = {pkgs, ...}: {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;
  };
}
