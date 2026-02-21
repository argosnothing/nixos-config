{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.remmina = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.remmina
      pkgs.pcsclite
      flake.packages.${pkgs.system}.rdp
    ];
  };
}
