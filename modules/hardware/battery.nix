{
  flake.modules.nixos.battery = {
    powerManagement.powertop.enable = true;
    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
    };
  };
}
