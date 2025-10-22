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
    my.persist = {
      home = {
        cache.directories = [
          ".cache/floorp"
        ];
        directories = [
          ".floorp"
        ];
      };
    };
    hm = {pkgs, ...}: {
      stylix.targets.floorp.profileNames = ["default"];
      programs.floorp = {
        enable = true;
        profiles = {
          "default" = {};
        };
        policies = {
          SecurityDevices = {
            "OpenSC PKCS#11 Module" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
          };
        };
      };
    };
  };
}
