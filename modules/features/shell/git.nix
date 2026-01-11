{config, ...}: let
  inherit (config.flake.settings) gitemail;
in {
  flake.modules.nixos.git = {
    config,
    lib,
    ...
  }: let
    username = config.user.name;
  in {
    hjem.users.${username} = {
      files = {
        ".gitconfig" = {
          generator = lib.generators.toINI {};
          value = {
            user = {
              name = username;
              email = gitemail;
            };
            core = {
              editor = "vim";
            };
          };
        };
        ".ssh/config" = {
          generator = lib.generators.toKeyValue {};
          value = {
            Host = "github.com";
            HostName = "github.com";
            User = "git";
            IdentityFile = "/run/secrets/ssh";
            IdentitiesOnly = "yes";
          };
        };
      };
    };
    programs.git = {
      enable = true;
      # TODO: module for this?
    };
  };
}
