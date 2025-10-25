{inputs, ...}: let
  flake.modules.nixos.vm = {
    imports = with inputs.self.modules.nixos; [
      base
    ];
    config.my.persist.enable = true;
  };
in {
  inherit flake;
}
