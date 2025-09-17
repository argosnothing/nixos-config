{pkgs, ...}: {
  imports = [
    ../configuration.nix # Import shared system configuration
    ./hardware-configuration.nix
    ./nvidia.nix
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
  hardware.keyboard.uhk.enable = true;

  services.udev.packages = with pkgs; [uhk-agent];
}
