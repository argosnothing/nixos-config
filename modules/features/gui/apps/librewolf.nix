{
  flake.modules.nixos.librewolf = {pkgs, ...}: {
    hm = {
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
