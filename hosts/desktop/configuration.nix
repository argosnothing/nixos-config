{
  inputs,
  pkgs,
  config,
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
  zfs.enable = true;
  custom.persist.enable = true;
  via.enable = true;
  environment.systemPackages = with pkgs; [
    cachix
    xorg.xev
    xdg-utils
  ];
}
