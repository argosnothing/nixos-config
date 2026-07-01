{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.flatpak = {pkgs, ...}: {
    services.flatpak.enable = true;
    services.packagekit.enable = true;
    services.fwupd.enable = true;
  };
}
