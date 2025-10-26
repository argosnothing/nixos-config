{inputs, ...}: let
  inherit (inputs.self.lib.mk-os) linux;

  flake.nixosConfigurations = {
    vm = linux "vm";
    laptop = linux "laptop";
    desktop = linux "desktop";
  };
in {
  inherit flake;
}
