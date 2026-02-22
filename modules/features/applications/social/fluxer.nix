{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.fluxer = {pkgs, ...}: {
    environment.systemPackages = [
      flake.packages.${pkgs.system}.fluxer
    ];
    my.persist.home.directories = [".config/fluxer"];
  };
}
