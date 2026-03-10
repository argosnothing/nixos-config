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
      # memacs
      work
      # uhk
      # flatpak
      # bolt-launcher
      # element-desktop
      # iamb
      vscode
      uhk
      # obs
      # remmina
      # winboat
      looking-glass
      # virtualization
      # fluxer

      # Meta
      impermanence
      uefi
      zfs
    ];
    services.pipewire.wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/50-default-sink.conf" ''
        wireplumber.settings = {
          default.configured-audio-sink = "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K7-00.analog-stereo"
        }
      '')
    ];
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="sound", ATTR{id}=="K7", RUN+="${pkgs.writeShellScript "fiio-wireplumber-restart" ''
        ${pkgs.systemd}/bin/systemd-run --no-block --uid=1000 \
          --setenv=XDG_RUNTIME_DIR=/run/user/1000 \
          ${pkgs.systemd}/bin/systemctl --user restart wireplumber
      ''}"
    '';
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
