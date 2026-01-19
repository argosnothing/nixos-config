## WITNESS MY SIN
{config, ...}: {
  flake.modules.nixos.windows = {pkgs, ...}: {
    hardware = {
      bluetooth.enable = true;
    };
    programs.nix-ld.enable = true;
    environment.systemPackages = with pkgs; [
      wdisplays
      wpa_supplicant
      waybar
      nixd
      rofi
      git
      lazygit
    ];
    imports = with config.flake.modules.nixos; [
      memacs

      packages
      sops
      user
      home
      shell-apps
      nix-settings
      options
      misc
    ];
    my = {
      quantum.files = [
        ".config/test.nix"
      ];
      username = "nixos";
      cursor.speed = -0.35;
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
            x = 3200;
            y = 402;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
  };
}
