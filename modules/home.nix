## Configure Anything that has to do with home stuff here.
{
  lib,
  inputs,
  ...
}: {
  flake.modules.nixos.home = {
    config,
    pkgs,
    ...
  }: let
    username = config.user.name;
  in {
    imports = [
      inputs.hjem.nixosModules.default
      (lib.mkAliasOptionModule ["hj"] ["hjem" "users" username])
      (lib.mkAliasOptionModule ["impure-dir"] ["hjem" "users" username "impure" "dotsDir"])
    ];
    config = {
      hj.xdg.config.files."mimeapps.list" = {
        generator = lib.generators.toINI {};
        value = {
          "Default Applications" = config.my.default.apps;
          "Added Associations" = lib.mapAttrs (_: apps: lib.concatStringsSep ";" apps + ";") config.my.default.associations;
        };
      };
      my.persist.home.directories = lib.mkAfter [
        ".local/share/direnv"
        ".local/share/keyrings"
        ".config/yazi"
        ".config/sops"
        ".ssh"
        "nixos-config"
        "Downloads"
        "Videos"
        "Pictures"
        "Projects"
      ];

      hjem = {
        extraModules = [inputs.hjem-impure.hjemModules.default];
        clobberByDefault = true;
        linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
        users.${username} = {
          impure = {
            enable = true;
            dotsDir = "${../.impure}";
            dotsDirImpure = "/home/${username}/nixos-config/.impure";
          };
          enable = true;
          user = username;
          directory = "/home/${username}";
          files = {
            ".editorconfig".text = ''
              root = true

              [*]
              charset = utf-8
              end_of_line = lf
              indent_style = space
              insert_final_newline = true
              tab_width = 2
            '';
          };
        };
      };
    };
  };
}
