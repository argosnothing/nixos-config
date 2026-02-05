### Base Options Module
# All code executed in modules assumes these options are available, even if they don't get used.
# options.nix will be in other folders as well, and those will be scoped to the modules that needs those options
{lib, ...}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) listOf str attrsOf;
  assertNoHomeDirs = paths:
    assert (lib.assertMsg (!lib.any (lib.hasPrefix "/home") paths) "/home used in a root persist!"); paths;
in {
  flake.modules.nixos.options = {
    options.my = {
      username = mkOption {
        description = "It's me!";
        type = str;
        default = "salivala";
      };
      hostname = mkOption {type = str;};
      is-vm = mkEnableOption "Is this a vm";
      is-multiple-wm = mkEnableOption "Flag to disable conflicting options for testing/experiment";
      default = {
        apps = mkOption {
          type = attrsOf str;
          default = {};
          example = {
            "text/html" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "inode/directory" = "thunar.desktop";
          };
          description = "MIME type to .desktop file mappings for default applications";
        };
        associations = mkOption {
          type = attrsOf (listOf str);
          default = {};
          description = "Additional applications that can handle each MIME type";
        };
      };
      persist = {
        enable = mkEnableOption "Enable Impermanence";
        keep-user-override = mkEnableOption "Ignore all home level persists and simply persist ~";
        root = {
          directories = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            apply = assertNoHomeDirs;
            description = "Directories to persist in root filesystem";
          };
          files = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            apply = assertNoHomeDirs;
            description = "Files to persist in root filesystem";
          };

          cache = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [];
              apply = assertNoHomeDirs;
              description = "Root directories to persist, but not to snapshot";
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [];
              apply = assertNoHomeDirs;
              description = "Root files to persist, but not to snapshot";
            };
          };
        };
        home = {
          directories = mkOption {
            type = listOf str;
            default = [];
            description = "Directories to persist in home directory";
          };
          files = mkOption {
            type = listOf str;
            default = [];
            description = "Files to persist in home directory";
          };
          cache = {
            directories = mkOption {
              type = listOf str;
              default = [];
              description = "Directories to persist, but not to snapshot";
            };
            files = mkOption {
              type = listOf str;
              default = [];
              description = "Files to persist, but not to snapshot";
            };
          };
        };
      };
    };
  };
}
