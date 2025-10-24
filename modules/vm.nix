{inputs, ...}: let
  flake.modules.nixos.vm = {
    imports = with inputs.self.modules.nixos; [
      base
    ];
    config.impermanence.enable = true;
  };
in {
  inherit flake;
}
