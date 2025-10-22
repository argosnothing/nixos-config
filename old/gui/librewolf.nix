{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.modules.gui.librewolf = {
    enable = mkEnableOption "Enable LibreWolf";
  };
  config = mkIf config.my.modules.gui.librewolf.enable {
    hm = _: {
      stylix.targets.librewolf.profileNames = ["default"];
      my.persist.home = {
        directories = [
          ".config/librewolf"
        ];
      };
      programs.librewolf = {
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
