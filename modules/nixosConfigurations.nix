{config, ...}: let
  inherit (config.flake.lib.mk-os) linux;
in {
  flake.nixosConfigurations = {
    vm = linux "vm";
    laptop = linux "laptop";
    t440s = linux "t440s";
    desktop = linux "desktop";
  };
}
