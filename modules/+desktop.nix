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
      viu
      qimgv
    ];

    imports = with config.flake.modules.nixos; [
      # WM
      niri-bundle

      # Apps
      gui-apps
      firefox
      zen-browser
      matrix-home-server
      claude-code
      vscode
      uhk
      looking-glass
      toys

      # Meta - no touchy
      impermanence
      uefi
      zfs
    ];
    my = {
      cursor.speed = -0.35;
      fonts.size = 11;
      is-vm = false;
      gpu-passthrough = {
        ids = ["10de:1f08" "10de:10f9" "10de:1ada" "10de:1adb"];
        kvmfr-size = 128;
      };
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
