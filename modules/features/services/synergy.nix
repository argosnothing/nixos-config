{
  flake.modules.nixos.synergy = {
    pkgs,
    lib,
    ...
  }: let
    inherit (lib.types) listOf submodule str int float;
    inherit (lib) mkOption mkEnableOption;
  in {
    options.my.synergy = {
      server = submodule {
        options = {
          enable = mkEnableOption "Enable Synergy Server";
        };
      };
      client = submodule {
        options = {
          enable = mkEnableOption "Enable Synergy Client";
        };
      };
    };
  };
}
