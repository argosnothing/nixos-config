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
      niri-bundle

      # Apps
      gui-apps
      firefox
      zen-browser
      memacs
      work
      uhk
      flatpak
      bolt-launcher
      element-desktop
      vscode
      obs

      # Meta
      impermanence
      uefi
      zfs
    ];
    my = {
      cursor.speed = -0.35;
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
      ];
    };
  };
}
