{
  lib,
  config,
  ...
}: let
  inherit (config.my.modules.shell) zellij;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.modules.shell.zellij = {
    enable = mkEnableOption "Enable Zellij";
  };
  config = mkIf zellij.enable {
    my.persist.home = {
      directories = [
        ".config/zellij"
      ];
      cache.directories = [
        ".cache/zellij"
      ];
    };
    hm = {
      home.shell.enableFishIntegration = true;
      programs.zellij = {
        enable = true;
        attachExistingSession = true;
        enableFishIntegration = true;
        exitShellOnExit = true;
      };
    };
  };
}
