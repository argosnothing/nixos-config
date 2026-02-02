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
    ];
    config = lib.optional {
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
        clobberByDefault = true;
        linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
        users.${username} = {
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
