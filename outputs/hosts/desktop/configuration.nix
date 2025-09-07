{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../configuration.nix # Import shared system configuration
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../../nixosModules/system
  ];

  steam.enable = true;
  via.enable = true;
  kernels.cachyos.enable = false; # dey broke dey flake!
  environment.systemPackages = with pkgs; [
    cachix
    xorg.xev
    xdg-utils
  ];
}
