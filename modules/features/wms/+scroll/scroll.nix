{inputs, ...}: {
  flake.modules.nixos.scroll = {pkgs, ...}: {
    modules = [
      inputs.scroll.nixosModules.default
    ];
  };
}
