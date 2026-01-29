{config, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    hardware = {
      bluetooth.enable = true;
    };
    environment.systemPackages = with pkgs; [
      wdisplays
      wpa_supplicant
      waybar
      nixd
      rofi
    ];
    imports = with config.flake.modules.nixos; [
      # WM
      hyprland-bundle

      # Apps
      gui-apps
      microsoft-edge
      firefox
      zen-browser
      memacs
      work
      uhk

      # Meta
      impermanence
      uefi
      zfs
    ];
    my = {
      cursor.speed = -0.35;
      theme.polarity = "dark";
      fonts.size = 11;
      is-vm = false;
      monitors = [
        {
          name = "DP-1";
          is-primary = true;
          dimensions = {
            width = 2560;
            height = 1440;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.0;
          refresh = 180.001;
        }
        {
          name = "DP-2";
          dimensions = {
            width = 1920;
            height = 1080;
          };
          position = {
            x = 2560;
            y = 205;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
  };
}
