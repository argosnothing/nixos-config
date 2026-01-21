{config, ...}: {
  flake.modules.nixos.laptop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wdisplays
    ];
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
    };
    imports = with config.flake.modules.nixos; [
      niri-bundle
      gui-apps

      vscode
      zed
      work
      krita

      battery
      touchpad

      # don't touch this
      uefi
      zfs
      impermanence
    ];
    my = {
      theme.polarity = "dark";
      cursor.speed = 0.30;
      is-vm = false;
      monitors = [
        {
          name = "HDMI-A-1";
          is-primary = true;
          dimensions = {
            width = 3840;
            height = 2160;
          };
          position = {
            x = 3587;
            y = 2586;
          };
          scale = 1.2;
          refresh = 60.0;
        }
        {
          name = "eDP-1";
          is-primary = true;
          dimensions = {
            width = 1920;
            height = 1080;
          };
          position = {
            x = 4258;
            y = 4386;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
  };
}
