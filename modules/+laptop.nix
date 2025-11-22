{config, ...}: let
  flake.modules.nixos.laptop = {
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
    };
    imports = with config.flake.modules.nixos; [
      niri-bundle
      work
      base
      gui-apps
      vscode
      shell-apps
      impermanence
      grub
      battery
      touchpad
    ];
    my = {
      theme.polarity = "light";
      cursor.speed = 0.30;
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
