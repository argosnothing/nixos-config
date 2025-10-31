{config, ...}: let
  flake.modules.nixos.t440s = {
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
    };
    imports = with config.flake.modules.nixos; [
      #
      # WMS
      #niri
      oxwm
      #xfce

      # Apps
      firefox

      base
      impermanence
      grub
      battery
      touchpad
    ];
    my = {
      is-vm = false;
      monitors = [
        {
          name = "eDP-1";
          is-primary = true;
          dimensions = {
            width = 1920;
            height = 1080;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
  };
in {
  inherit flake;
}
