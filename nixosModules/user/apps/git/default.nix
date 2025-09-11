{pkgs, settings, lib, config, ...}: {
  options = {
    git.enable = lib.mkEnableOption "Home manager save me";
  };
  config = lib.mkIf config.options.enable {
    programs.git = {
      enable = true;
      userName = settings.username;
      userEmail = "banana";
    };
  };
}
