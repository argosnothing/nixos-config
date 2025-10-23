{ inputs, ...}: {
  flake.modules.nixos.critical = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}
