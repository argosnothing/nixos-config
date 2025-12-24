{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.plasma = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      inotify-tools
      ocs-url
    ];
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      desktopManager = {
        plasma6.enable = true;
      };
    };
  };
}
