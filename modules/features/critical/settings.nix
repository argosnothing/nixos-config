{
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) str;
in {
  options.settings = {
    username = mkOption {
      description = "It's me!";
      type = str;
      default = "salivala";
    };
    persist.enable = mkEnableOption "Enable Impermanence";
  };
}
