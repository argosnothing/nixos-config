{
  inputs,
  config,
  lib,
  ...
}: let
  flake.lib.mk-os = {
    inherit mkNixos;
    inherit linux;
    inherit wsl;
  };

  linux = mkNixos "x86_64-linux";
  wsl = mkWsl "x86_64-linux";

  mkWsl = system: name:
    inputs.nixpkgs-wsl.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.nixos-wsl.nixosModules.default
        config.flake.modules.nixos.${name}
        {
          my.hostname = "nixos";
          networking.hostName = lib.mkDefault name;
          nixpkgs = {
            hostPlatform = lib.mkDefault system;
            overlays = [
              (_: super: {
                inherit (super.stdenv.hostPlatform) system;
              })
            ];
            config = {
              allowUnfree = true;
              showAliases = true;
            };
          };
          system.stateVersion = "25.05";
        }
      ];
    };

  mkNixos = system: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        config.flake.modules.nixos.base
        config.flake.modules.nixos.cursor
        config.flake.modules.nixos.${name}
        {
          my.hostname = name;
          networking.hostName = lib.mkDefault name;
          nixpkgs = {
            hostPlatform = lib.mkDefault system;
            overlays = [
              (_: super: {
                inherit (super.stdenv.hostPlatform) system;
              })
            ];
            config = {
              allowUnfree = true;
              showAliases = true;
            };
          };
          system.stateVersion = "25.05";
        }
      ];
    };
in {
  inherit flake;
}
