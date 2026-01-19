{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.plasma = {pkgs, ...}: {
    # I have given up. Fine, plasma, here is the entire userspace for you to mess up
    my.persist.keep-user-override = true;
    systemd.user.services = {
      baloo-file.enable = false;
      baloo-file-extractor.enable = false;
      plasma-baloorunner.enable = false;
    };
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
