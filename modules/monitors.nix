{lib, ...}: let
  inherit (lib.types) listOf submodule attrsOf str int bool;
  inherit (lib) mkOption mkEnableOption;
in {
  options.my.modules.monitors = mkOption {
    description = "List of monitors to manage";
    default = [{}];
    type = listOf (submodule {
      options = {
        is-primary = mkEnableOption "Primary Monitor";
        name = mkOption {
          type = str;
          example = "DP-1";
          description = "Name Identifier of a monitor";
        };

        width = mkOption {
          type = int;
          example = 1920;
          description = "Width of the monitor";
        };

        height = mkOption {
          type = int;
          example = 1080;
          description = "Height of the monitor";
        };

        position = mkOption {
          type = submodule {
            x = mkOption {
              type = int;
              description = "x-position of monitor";
            };
            y = mkOption {
              type = int;
              description = "y-position of monitor";
            };
          };
        };

        scale = mkOption {
          description = "scale of a monitor (use 1, 1.25, etc.)";
          type = str;
          default = "1";
        };

        refresh = mkOption {
          description = "refresh rate of monitor";
          type = str;
          default = "60";
        };
      };
    });
  };
}
