{config, ...}: let
  inherit (config.flake.settings) username gitemail;
in {
  flake.modules.nixos.git = {lib, ...}: {
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
