{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.modules

  ];
  flake.modules.nixos.imports = [
    inputs.sops-nix.nixosModules.sops
  ];
}
