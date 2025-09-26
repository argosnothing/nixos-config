{pkgs, ...}: {
  imports = [
    ../configuration.nix # Import shared system configuration
    ./hardware-configuration.nix
  ];

  # Laptop-specific configuration
  # Using default kernel (not xanmod) for battery life
  hardware.graphics.enable = true;

  # Laptop-specific packages
  environment.systemPackages = with pkgs; [
  ];
}
