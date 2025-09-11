{pkgs, settings, lib, config, ...}: {
  options = {
    git.enable = lib.mkEnableOption "Home manager save me";
  };
  config = lib.mkIf config.git.enable {
    programs.ssh.enable = true;
    services.ssh-agent.enable = true;
    programs.git = {
      enable = true;
      userName = settings.username;
      userEmail = settings.gitEmail;
    };
  };
}
