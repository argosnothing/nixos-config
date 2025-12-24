{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (config.flake.settings) username;
in {
  flake.modules.nixos.impermanence = {config, ...}: let
    cfg = config.my.persist;
  in {
    my.persist.enable = true;
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];
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
        files = lib.unique cfg.root.files;
        directories = lib.unique (
          [
            "/var/log" # systemd journal is stored in /var/log/journal
            "/var/lib/nixos" # user uids and gids
            "/var/lib/systemd/coredump"
          ]
          ++ cfg.root.directories
        );

        users.${username} =
          if cfg.keep-user-override
          then {
            files = [];
            directories = ["."];
          }
          else {
            files = lib.unique cfg.home.files;
            directories = lib.unique (
              [
                ".cache/dconf"
                ".config/dconf"
              ]
              ++ cfg.home.directories
            );
          };
      };

      # Cache are files that should be persisted, but not backed up
      "/cache" = {
        hideMounts = true;
        files = lib.unique (["/etc/machine-id"] ++ cfg.root.cache.files);
        directories = lib.unique cfg.root.cache.directories;

        users.${username} =
          if cfg.keep-user-override
          then {
            files = [];
            directories = [".cache"];
          }
          else {
            files = lib.unique cfg.home.cache.files;
            directories = lib.unique cfg.home.cache.directories;
          };
      };
    };
  };
}
