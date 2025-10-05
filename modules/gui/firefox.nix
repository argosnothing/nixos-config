{
  pkgs,
  settings,
  lib,
  config,
  ...
}: let
in {
  options = {
    my.modules.gui.firefox = {
      enable = lib.mkEnableOption "My firefox";
    };
  };
  config = lib.mkIf config.my.modules.gui.firefox.enable {
    hm = {pkgs, ...}: {
      programs.firefox = {
        enable = true;
        policies = {
          SecurityDevices = {
            "OpenSC PKCS#11 Module" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
          };
        };
      };
    };
    environment = {
      sessionVariables = {
        DEFAULT_BROWSER = lib.getExe pkgs.firefox;
        BROWSER = lib.getExe pkgs.firefox;
      };
    };
  };
}
