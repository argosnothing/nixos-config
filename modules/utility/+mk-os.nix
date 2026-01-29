{
  inputs,
  config,
  lib,
  self,
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
        config.flake.modules.nixos.cursor
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

  mkNixos = system: name: let
    ## Credit: Iynaix
    nixpkgs-bootstrap = import inputs.nixpkgs {inherit system;};
    # apply patches from nixpkgs
    nixpkgs-patched = nixpkgs-bootstrap.applyPatches {
      name = "nixpkgs-iynaix";
      src = inputs.nixpkgs;
      patches = map nixpkgs-bootstrap.fetchpatch self.patches;
    };
    nixosSystem = import (nixpkgs-patched + "/nixos/lib/eval-config.nix");
  in
    nixosSystem {
      inherit system;
      modules = [
        inputs.quantum.nixosModules.default
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
              permittedInsecurePackages = [
                "libsoup-2.74.3"
              ];
            };
          };
          system.stateVersion = "25.05";
        }
      ];
    };
in {
  inherit flake;
}
