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
    uhk-agent
    cachix
    xorg.xev
    xdg-utils
  ];
  custom.persist.home.directories = [".config/uhk-agent"];

  services.udev.packages = with pkgs; [uhk-agent];
}
