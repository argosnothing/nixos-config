{pkgs, lib, settings, config, ...}: {
  options = {
    zoxide.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "zoxide for me";
    };
  };

  config = lib.mkIf config.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
