## WITNESS MY SIN
{config, ...}: {
  flake.modules.nixos.windows = {pkgs, ...}: {
    hardware = {
      bluetooth.enable = true;
    };
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
      nh
      nix-settings
      base
    ];
  };
}
