{
  inputs,
  config,
  lib,
  ...
}: let
  flake.lib.mk-os = {
    inherit mkNixos;
    inherit linux;
  };

  linux = mkNixos "x86_64-linux" "nixos";

  mkNixos = system: cls: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        config.flake.modules.nixos.${cls}
        config.flake.modules.nixos.${name}
        {
          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = "25.05";
        }
       #inputs.home-manager.nixosModules.home-manager {
       #  imports = [config.flake.homeManager.vm];
       #}
      ];
    };
in {
  inherit flake;
}
