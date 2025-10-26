## Options for the system.
{lib, ...}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) listOf str;
  assertNoHomeDirs = paths:
    assert (lib.assertMsg (!lib.any (lib.hasPrefix "/home") paths) "/home used in a root persist!"); paths;
in {
  flake.modules.homeManager.options = {
    options.my.persist.home = {
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
  flake.modules.nixos.options = {
    options.my = {
      hostname = mkOption {type = str;};
      is-vm = mkEnableOption "Is this a vm";
      persist = {
        enable = mkEnableOption "Enable Impermanence";
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
