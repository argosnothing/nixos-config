{
  inputs,
lib,
  ...
}: let
  flake.lib.mk-os = {
    inherit mkNixos;
    inherit wsl linux linux-arm;
  };

  wsl = mkNixos "x86_64-linux" "wsl";

  linux = mkNixos "x86_64-linux" "nixos";
  linux-arm = mkNixos "aarch64-linux" "nixos";

  mkNixos = system: cls: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.self.modules.nixos.${cls}
        inputs.self.modules.nixos.${name}
        {
          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = "25.05";
        }
      ];
    };
in {
  inherit flake;
}
