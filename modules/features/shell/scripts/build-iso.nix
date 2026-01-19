### cursed, please ignore this horrible breach of sanity
{
  flake.modules.nixos.build-iso = {
    config,
    pkgs,
    ...
  }: let
    inherit (config.my) username;
    flakedir = "/home/${username}/nixos-config";
  in {
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "build-iso" ''
        set -euo pipefail
        cd ${flakedir}
        nix build \
          --impure \
          --expr '
            let
              flake = builtins.getFlake (toString ./.);
              lib = flake.inputs.nixpkgs.lib;
              system = "x86_64-linux";
              isoConfig = lib.nixosSystem {
                inherit system;
                specialArgs = {
                  inputs = flake.inputs;
                  self = flake;
                };
                modules = [
                  flake.modules.nixos.iso
                  { networking.hostName = "kickstart"; }
                ];
              };
            in isoConfig.config.system.build.isoImage
          '
        echo "ISO built: $(readlink -f result)/iso/"
      '')
    ];
  };
}
