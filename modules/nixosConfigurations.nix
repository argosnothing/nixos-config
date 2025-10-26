{config, ...}: let
  inherit (config.flake.lib.mk-os) linux;
in {
  flake.nixosConfigurations = {
    vm = linux "vm";
    laptop = linux "laptop";
    desktop = linux "desktop";
  };
}
