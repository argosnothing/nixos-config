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
    ../../nixosModules/system
  ];

  steam.enable = true;
  via.enable = true;
  kernels.chaotic.enable = true;
  environment.systemPackages = with pkgs; [
    xorg.xev
    xdg-utils
  ];
}
