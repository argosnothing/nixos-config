{
  flake.modules.nixos = {
    critical = {
      lib,
      config,
      ...
    }: let
      cfg = config.my.persist;
      hmCfg = config.hm.my.persist;
      username = config.user.name;
      enable = config.persist.enable;
      inherit (lib) mkOption mkEnableOption mkIf;
      inherit (lib.types) listOf str;
      assertNoHomeDirs = paths:
        assert (lib.assertMsg (!lib.any (lib.hasPrefix "/home") paths) "/home used in a root persist!"); paths;
    in {
      options.my = {
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

      config =
        {
          hm = {lib, ...}: let
            inherit (lib) mkOption;
            inherit (lib.types) listOf str;
          in {
            options.my = {
              persist = {
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
        // lib.optionalAttrs enable {
          security.sudo.extraConfig = "Defaults lecture=never";

          fileSystems."/" = lib.mkForce {
            device = "tmpfs";
            fsType = "tmpfs";
            neededForBoot = true;
            options = [
              "defaults"
              "size=2G" # whatever size you feel comfortable with
              "mode=755"
            ];
          };

          fileSystems = {
            "/nix".neededForBoot = true;
            "/boot".neededForBoot = true;
            "/cache".neededForBoot = true;
            "/persist".neededForBoot = true;
          };

          environment.persistence = {
            "/persist" = {
              hideMounts = false;
              files =
                lib.unique cfg.root.files;
              directories = lib.unique (
                [
                  "/var/log" # systemd journal is stored in /var/log/journal
                  "/var/lib/nixos" # user uids and gids
                  "/var/lib/systemd/coredump"
                ]
                ++ cfg.root.directories
              );

              users.${username} = {
                files = lib.unique (cfg.home.files ++ hmCfg.home.files);
                directories =
                  lib.unique
                  (
                    [
                      ".cache/dconf"
                      ".config/dconf"
                    ]
                    ++ cfg.home.directories
                    ++ hmCfg.home.directories
                  );
              };
            };

            # Cache are files that should be persisted, but not backed up
            "/cache" = {
              hideMounts = true;
              files = lib.unique (["/etc/machine-id"] ++ cfg.root.cache.files);
              directories = lib.unique cfg.root.cache.directories;

              users.${username} = {
                files = lib.unique (cfg.home.cache.files ++ hmCfg.home.cache.files);
                directories = lib.unique (cfg.home.cache.directories ++ hmCfg.home.cache.directories);
              };
            };
          };
        };
    };
  };
}
