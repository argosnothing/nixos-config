## Configure Anything that has to do with home stuff here.
{
  lib,
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.home = {pkgs, ...}: {
    imports = [
      inputs.hjem.nixosModules.default
      (lib.mkAliasOptionModule ["hj"] ["hjem" "users" flake.settings.username])
    ];
    config = {
      my.persist.home.directories = lib.mkAfter [
        ".local/share/direnv"
        ".local/share/keyrings"
        ".config/yazi"
        ".config/sops"
        ".ssh"
        "nixos-config"
      ];

      #hj.systemd.enable = false;
      hjem = {
        extraModules = [
          inputs.hjem-rum.hjemModules.default
        ];
        clobberByDefault = true;
        linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
        users.${flake.settings.username} = {
          enable = true;
          user = flake.settings.username;
          directory = "/home/${flake.settings.username}";
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
