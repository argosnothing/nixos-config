{pkgs, ...}: {
  imports = [
    ../configuration.nix # Import shared system configuration
    ./hardware-configuration.nix
    ./input.nix
    ./nvidia.nix
  ];

  # P51-specific configuration
  # Using default kernel (not xanmod) for stability on older hardware

  # P51-specific packages
  environment.systemPackages = with pkgs; [
    libinput # Touchpad support
    home-manager
    swayidle # Power management
  ];
}
