{config, ...}: let
  flake.settings.isVm = true;
  flake.modules.nixos.vm = {
    imports = with config.flake.modules.nixos; [
      base
      impermanence
      uefi
      #niri
      xfce

      firefox
    ];
    my = {
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
