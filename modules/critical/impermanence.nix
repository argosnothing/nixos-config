{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.critical = {config, ...}: let
  in {
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

    # environment.persistence = {
    #   "/persist" = {
    #     hideMounts = false;
    #     files =
    #       lib.unique cfg.root.files;
    #     directories = lib.unique (
    #       [
    #         "/var/log" # systemd journal is stored in /var/log/journal
    #         "/var/lib/nixos" # user uids and gids
    #         "/var/lib/systemd/coredump"
    #       ]
    #       ++ cfg.root.directories
    #     );

    #     users.${username} = {
    #       files = lib.unique (cfg.home.files ++ hmCfg.home.files);
    #       directories =
    #         lib.unique
    #         (
    #           [
    #             ".cache/dconf"
    #             ".config/dconf"
    #           ]
    #           ++ cfg.home.directories
    #           ++ hmCfg.home.directories
    #         );
    #     };
    #   };

    #   # Cache are files that should be persisted, but not backed up
    #   "/cache" = {
    #     hideMounts = true;
    #     files = lib.unique (["/etc/machine-id"] ++ cfg.root.cache.files);
    #     directories = lib.unique cfg.root.cache.directories;

    #     users.${username} = {
    #       files = lib.unique (cfg.home.cache.files ++ hmCfg.home.cache.files);
    #       directories = lib.unique (cfg.home.cache.directories ++ hmCfg.home.cache.directories);
    #     };
    #   };
    # };
  };
}
