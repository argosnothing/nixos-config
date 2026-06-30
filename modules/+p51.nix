{config, ...}: let
  flake.modules.nixos.p51 = {
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
    };
    imports = with config.flake.modules.nixos; [
      helix
      firefox
      discord
      claude-code

      grub
      battery
      touchpad
      zfs
    ];
    my = {
      is-vm = false;
      hardware.keyd.hhkb-override.enable = true;
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
