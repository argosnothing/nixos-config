{config, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    hardware = {
      bluetooth.enable = true;
    };
    environment.systemPackages = with pkgs; [
      nixd
      viu
      qimgv
    ];

    imports = with config.flake.modules.nixos; [
      # WM
      plasma

      # Apps
      gui-apps
      firefox
      claude-code
      rdp

      # Meta - no touchy
      uefi
      zfs
    ];
    my = {
      cursor.speed = -0.35;
      fonts.size = 11;
      is-vm = false;
      zfs.arcMax = 8589934592;
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
