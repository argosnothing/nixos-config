{config, ...}: let
  flake.modules.nixos.laptop = {
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
    };
    services = {
      libinput.enable = true;
      libinput.touchpad = {
        accelSpeed = "0.7";
        accelProfile = "flat";
        naturalScrolling = true;
        tapping = true;
      };
    };
    imports = with config.flake.modules.nixos; [
      #
      work
      # WMS
      #niri
      xfce
      # Apps
      firefox

      base
      impermanence
      grub
    ];
    my = {
      is-vm = false;
      monitors = [
        {
          name = "Virtual-1";
          is-primary = true;
          dimensions = {
            width = 500;
            height = 500;
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
