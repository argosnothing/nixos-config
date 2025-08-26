{
  inputs,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ../configuration.nix # Import shared system configuration
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ../../nixosModules/system
  ];

  # Laptop-specific configuration
  # Using default kernel (not xanmod) for battery life
  
  # Laptop-specific packages
  environment.systemPackages = with pkgs; [
    home-manager
    swayidle # Idle management for laptop power saving
  ];
}
