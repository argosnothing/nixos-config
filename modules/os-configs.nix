{inputs, ...}: let
  inherit (inputs.self.lib.mk-os) linux;

  flake.nixosConfigurations = {
    vm = linux "vm";
  };
in {
  inherit flake;
}
