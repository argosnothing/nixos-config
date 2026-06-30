{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.cinnamon = {pkgs, ...}: {
    imports = with flake.modules.nixos; [
      lightdm
    ];
    environment.cinnamon.excludePackages = with pkgs; [
      gnome-terminal
    ];
    services.xserver = {
      excludePackages = with pkgs; [xterm];
      enable = true;
      desktopManager.cinnamon = {
        enable = true;
      };
    };
  };
}
