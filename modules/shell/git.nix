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
    services.ssh-agent.enable = true;
    programs.git = {
      enable = true;
      userName = settings.username;
      userEmail = settings.gitEmail;
    };
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/run/secrets/ssh";
        identitiesOnly = true;
      };
    };
  };
}
