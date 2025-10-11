{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my.modules.gui.floorp) enable;
in {
  options.my.modules.gui.floorp = {
    enable = mkEnableOption "Enable Floorp Browser";
  };
  config = mkIf enable {
    hm = {pkgs, ...}: {
      programs.floorp = {
        enable = true;
        policies = {
          SecurityDevices = {
            "OpenSC PKCS#11 Module" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
          };
        };
      };
    };
  };
}
