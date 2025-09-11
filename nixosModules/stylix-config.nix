{
  inputs,
  config,
  lib,
  pkgs,
  settings,
  ...
}: {
  options = {
    styles.stylix.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Stylix system configuration.";
    };
  };
}
