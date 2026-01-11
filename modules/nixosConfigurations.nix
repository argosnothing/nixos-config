{config, ...}: let
  inherit (config.flake.lib.mk-os) linux;
  inherit (config.flake.lib.mk-os) wsl;
in {
  flake.nixosConfigurations = {
    vm = linux "vm";
    laptop = linux "laptop";
    t440s = linux "t440s";
    p51 = linux "p51";
    desktop = linux "desktop";
    wsl = wsl "windows";
  };
}
