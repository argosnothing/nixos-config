{inputs, ...}: {
  flake.modules.nixos.nixos.imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
}
