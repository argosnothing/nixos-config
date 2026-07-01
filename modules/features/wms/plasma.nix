{
  flake.modules.nixos.plasma = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      kdePackages.oxygen
      kdePackages.oxygen-icons
      kdePackages.oxygen-sounds
      kdePackages.kdeconnect-kde
      kdePackages.discover
    ];
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;
  };
}
