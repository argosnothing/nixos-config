{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.modules

  ];
  flake.modules.nixos.imports = [
  ];
}
