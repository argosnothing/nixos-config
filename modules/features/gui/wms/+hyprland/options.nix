{
  flake.modules.nixos.hyprland = {lib, ...}: let
    inherit (lib) types mkOption;
    inherit (types) str listOf;
  in {
    options.my.wm.hyprland.settings = mkOption {
      type = listOf str;
      description = "list of strings for hyprland settings";
      default = [];
    };
  };
}
