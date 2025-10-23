{inputs, ...}: let
  flake.modules.nixos.vm = {
    imports = with inputs.self.modules.nixos; [
      critical
    ];
  };
in {
  inherit flake;
}
