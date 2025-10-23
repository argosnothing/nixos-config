{inputs, ...}: {
  debug = true;
  flake.modules.nixos.vm.imports = with inputs.self.modules.nixos; [
    critical
  ];
}
