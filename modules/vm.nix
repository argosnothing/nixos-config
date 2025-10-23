{inputs, ...}: let
  flake.modules.nixos.vm = {
    imports = with inputs.self.modules.nixos; [
      user
      critical
    ];
  };
in {
  inherit flake;
}
