{
  flake.modules.nixos.plasma = {pkgs, ...}: {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

  };
}
