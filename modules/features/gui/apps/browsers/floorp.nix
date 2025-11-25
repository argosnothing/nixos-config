{
  flake.modules.nixos.floorp = {
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
