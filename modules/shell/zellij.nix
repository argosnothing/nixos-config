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
    hm = {
      programs.zellij = {
        enable = true;
      };
    };
  };
}
