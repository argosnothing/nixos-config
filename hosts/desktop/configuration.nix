{
  inputs,
  pkgs,
  lib,
  pkgsUnstable,
  ...
}: {
  imports = [
    ../configuration.nix # Import shared system configuration
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../nixosModules/system
  ];

  # Desktop-specific configuration
  kernels.xandmod.enable = true; # Enable high-performance kernel for desktop

  # Desktop-specific packages
  environment.systemPackages = with pkgs; [
    inputs.swww.packages.${pkgs.system}.swww # Desktop wallpaper manager
    xdg-utils
  ];
}
