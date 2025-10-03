{
  pkgs,
  settings,
  lib,
  config,
  ...
}: {
  options = {
    my.modules.shell.git.enable = lib.mkEnableOption "Home manager save me";
  };
  config = lib.mkIf config.my.modules.shell.git.enable {
    hjem.users.${settings.username} = {
      files = {
        ".gitconfig" = {
          generator = lib.generators.toINI {};
          value = {
            user = {
              name = settings.username;
              email = settings.gitEmail;
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
      # userName = settings.username;
      # userEmail = settings.gitEmail;
    };
  };
}
