{lib, ...}: {
  options.flake.settings = {
    gitemail = lib.mkOption {
      description = "git email";
      default = "argosnothing@gmail.com";
      type = lib.types.str;
    };
    networking.hostId = lib.mkOption {
      description = "Host Id";
      type = lib.types.str;
      default = "AB12CD34";
    };
  };

  flake.modules.nixos.options = {
    pkgs,
    lib,
    config,
    ...
  }: let
    inherit (lib.types) int listOf submodule str float package attrsOf enum nullOr;
    inherit (lib) mkOption mkEnableOption;
    inherit (config.my.fonts) mono sans serif size;
  in {
    options.my = {
      username = mkOption {
        description = "It's me!";
        type = str;
        default = "salivala";
      };
      hostname = mkOption {type = str;};
      is-vm = mkEnableOption "Is this a vm";
      is-multiple-wm = mkEnableOption "Flag to disable conflicting options for testing/experiment";
      zfs.arcMax = mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "ZFS ARC max size in bytes. Null means no cap (ZFS default).";
        example = 8589934592;
      };
      default = {
        apps = mkOption {
          type = attrsOf str;
          default = {};
          description = "MIME type to .desktop file mappings for default applications";
        };
        associations = mkOption {
          type = attrsOf (listOf str);
          default = {};
          description = "Additional applications that can handle each MIME type";
        };
      };

      monitors = mkOption {
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
                  width = mkOption {type = int; example = 1920; default = 1920;};
                  height = mkOption {type = int; example = 1080; default = 1080;};
                };
              };
            };
            position = mkOption {
              type = submodule {
                options = {
                  x = mkOption {type = int; default = 0;};
                  y = mkOption {type = int; default = 0;};
                };
              };
            };
            scale = mkOption {type = float; default = 1.0;};
            refresh = mkOption {type = float; default = 60.0;};
          };
        });
      };

      fonts = {
        size = mkOption {type = int; default = 11;};
        sizes = mkOption {
          default = {};
          type = submodule {
            options = {
              applications = mkOption {type = int; default = size;};
              terminal = mkOption {type = int; default = size;};
              desktop = mkOption {type = int; default = size;};
              popups = mkOption {type = int; default = size;};
            };
          };
        };
        mono = {
          name = mkOption {default = "FiraCode Nerd Font"; type = str;};
          package = mkOption {default = pkgs.nerd-fonts.fira-code; type = package;};
        };
        sans = {
          name = mkOption {default = "Noto Sans"; type = str;};
          package = mkOption {default = pkgs.noto-fonts; type = package;};
        };
        serif = {
          name = mkOption {default = "Noto Serif"; type = str;};
          package = mkOption {default = pkgs.noto-fonts; type = package;};
        };
      };

      session = mkOption {
        type = submodule {
          options = {
            name = mkOption {type = str;};
            exec-command = mkOption {type = str;};
          };
        };
      };
      sessions = mkOption {
        description = "Registered desktop and window manager info";
        default = [{}];
        type = listOf (submodule {
          options = {
            manage = enum ["desktop" "window"];
            name = mkOption {type = str;};
            start = mkOption {type = str;};
            package = mkOption {type = nullOr package;};
          };
        });
      };
      startup-services = mkOption {
        type = listOf str;
        default = [];
      };
    };

    config = {
      my.fonts = {
        serif = {name = "Alegreya Serif"; package = pkgs.google-fonts;};
        mono = {name = "Cascadia Code"; package = pkgs.cascadia-code;};
      };
      fonts.packages = with pkgs; [
        mono.package
        sans.package
        serif.package
        nerd-fonts.noto
        nerd-fonts.symbols-only
        font-awesome
      ];
      fonts.fontconfig.defaultFonts = {
        monospace = [mono.name];
        sansSerif = [sans.name];
        serif = [serif.name];
      };
    };
  };
}
