## Options for the system.
{lib, ...}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) listOf str;
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
      quantum = {
        enable = mkEnableOption "Enable Stow";
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
