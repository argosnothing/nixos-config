{config, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    hardware = {
      bluetooth.enable = true;
    };
    environment.systemPackages = with pkgs; [transmission_4-gtk];
    imports = with config.flake.modules.nixos; [
      niri
      #mango
      kitty
      discord
      work
      #zwift - broke
      steam
      firefox
      nemo
      spotify-player
      spicetify
      zellij
      audacity
      flatpak
      via
      plex
      mullvad
      rose-pine

      uefi
      base
      impermanence
    ];
    my = {
      fonts.size = 11;
      is-vm = false;
      monitors = [
        {
          name = "DP-1";
          is-primary = true;
          dimensions = {
            width = 3840;
            height = 2160;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.2;
          refresh = 143.851;
        }
        {
          name = "DP-2";
          dimensions = {
            width = 1920;
            height = 1080;
          };
          position = {
            x = 3202;
            y = 402;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
  };
}
