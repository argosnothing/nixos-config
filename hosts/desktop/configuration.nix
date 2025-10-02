{pkgs, ...}: {
  imports = [
    ../shared/configuration.nix # Import shared system configuration
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  my = {
    modules = {
      critical.zfs.enable = true;
      misc.citrix.enable = true;
    };
    persist.enable = true;
  };

  environment.systemPackages = with pkgs; [
    uhk-agent
    cachix
    xorg.xev
    xdg-utils
  ];
  my.persist.home.directories = [".config/uhk-agent"];
  hardware.keyboard.uhk.enable = true;

  services.udev.packages = with pkgs; [uhk-agent];
}
