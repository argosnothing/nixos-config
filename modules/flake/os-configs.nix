{inputs, ...}: let
  inherit
    (inputs.self.lib.mk-os)
    linux
    linux-arm
    ;

  flake.nixosConfigurations = {
    vm = linux "vm";
  };
in {
  inherit flake;
}
