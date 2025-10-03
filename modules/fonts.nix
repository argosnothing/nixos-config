{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str package;
in {
  options.my.modules.fonts = {
    mono = {
      name = mkOption {
        description = "Name of Mono Font";
        default = "FiraCode Nerd Font";
        type = str;
      };
      package = mkOption {
        description = "Package of Mono Font";
        default = pkgs.nerd-fonts.fira-code;
        type = package;
      };
    };
    sans = {
      name = mkOption {
        description = "Name of Sans Font";
        default = "Liberation Sans";
        type = str;
      };
      package = mkOption {
        description = "Package of Sans Font";
        default = pkgs.liberation_ttf;
        type = package;
      };
    };
    serif = {
      name = mkOption {
        description = "Name of Serif Font";
        default = "Liberation Serif";
        type = str;
      };
      package = mkOption {
        description = "Package of Serif Font";
        default = pkgs.liberation_ttf;
        type = package;
      };
    };
  };
}
