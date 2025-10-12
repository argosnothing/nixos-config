{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str package;
in {
  options.my.modules.icons = {
    package = mkOption {
      description = "Set Icon Pack";
      type = package;
      default = pkgs.tela-icon-theme;
    };
    name = mkOption {
      description = "Set Icon Name";
      type = str;
      default = "Tela";
    };
  };
}
