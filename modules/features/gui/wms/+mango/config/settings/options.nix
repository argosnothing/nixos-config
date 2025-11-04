{
  flake.modules.nixos.mango = {lib, ...}: let
    inherit (lib) types mkOption;
    inherit (types) str listOf;
  in {
    options = {
      my.wm.mango = {
        settings = mkOption {
          type = listOf str;
          description = "list of strings for mango settings";
          default = [];
        };
      };
    };
  };
}
