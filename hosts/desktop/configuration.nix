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
  environment.systemPackages = with pkgs; [
    xorg.xev
    inputs.swww.packages.${pkgs.system}.swww # Desktop wallpaper manager
    xdg-utils
  ];
}
