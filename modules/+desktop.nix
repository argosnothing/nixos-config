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
      # hyprland-bundle
      # cosmic
      # cinnamon
      # niri-bundle
      plasma
      # xfce-bundle

      # Apps
      gui-apps
      firefox
      claude-code
      vscode
      uhk
      looking-glass
      bolt-launcher
      flatpak
      zed
      rdp

      # Meta - no touchy
      impermanence
      uefi
      zfs
    ];
    my = {
      cursor.speed = -0.35;
      fonts.size = 11;
      is-vm = false;
      zfs.arcMax = 8589934592;
      gpu-passthrough = {
        # RTX 2060 (0a:00.0)
        ids = ["10de:1f08" "10de:10f9" "10de:1ada" "10de:1adb"];
        # RTX 4070 (09:00.0)
        # ids = ["10de:2786" "10de:22bc"];
        kvmfr-size = 128;
      };
      monitors = [
        {
          name = "DP-1"; # DP-0 for X. no idea why
          is-primary = true;
          dimensions = {
            width = 2560;
            height = 1440;
          };
          position = {
            x = 1367;
            y = 0;
          };
          scale = 1.0;
          refresh = 180.00101;
        }
        {
          name = "HDMI-A-1";
          is-primary = false;
          dimensions = {
            width = 2560;
            height = 1440;
          };
          position = {
            x = 1706;
            y = 1440;
          };
          scale = 1.30;
          refresh = 120.00;
        }
      ];
    };
  };
}
