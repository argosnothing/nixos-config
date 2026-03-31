{config, ...}: {
  flake.modules.nixos.t440s = {lib, ...}: {
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
    };
    imports = with config.flake.modules.nixos; [
      xfce
      firefox
      gui-apps

      impermanence
      uefi
      battery
      zfs
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
}
