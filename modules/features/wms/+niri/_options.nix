{
  flake.modules.nixos.niri = {lib, ...}: let
    inherit (lib) types mkOption mkEnableOption;
    inherit (types) str listOf;
  in {
    options = {
      my.wm.niri = {
        settings = mkOption {
          type = listOf str;
          description = "list of strings for niri settings";
          default = [];
        };
        use-scratchpads = mkEnableOption "Enable Scratchpads";
      };
    };
  };
}
