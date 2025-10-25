{lib, ...}: let
  inherit (lib.types) listOf submodule str int float;
  inherit (lib) mkOption mkEnableOption;
in {
  flake.modules.nixos.options = {
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

          dimensions = mkOption {
            type = submodule {
              options = {
                width = mkOption {
                  type = int;
                  example = 1920;
                  default = 1920;
                  description = "Width of the monitor";
                };

                height = mkOption {
                  type = int;
                  example = 1080;
                  default = 1080;
                  description = "Height of the monitor";
                };
              };
            };
          };

          position = mkOption {
            type = submodule {
              options = {
                x = mkOption {
                  type = int;
                  default = 0;
                  description = "x-position of monitor";
                };
                y = mkOption {
                  type = int;
                  default = 0;
                  description = "y-position of monitor";
                };
              };
            };
          };

          scale = mkOption {
            description = "scale of a monitor (use 1, 1.25, etc.)";
            type = float;
            default = 1.0;
          };

          refresh = mkOption {
            description = "refresh rate of monitor";
            type = float;
            default = 60.0;
          };
        };
      });
    };
  };
}
