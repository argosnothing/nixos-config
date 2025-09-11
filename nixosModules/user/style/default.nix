{
  pkgs,
  config,
  lib,
  inputs,
  settings,
  ...
}:let
  
  hasStylix = config.styles.stylix.enable;
in  {
  imports = [
    inputs.stylix.homeModules.stylix
    ../../stylix-config.nix
  ];
  config = lib.mkMerge [
    (lib.mkIf hasStylix {
      stylix.targets.hyprland.enable = true;
      stylix.targets.firefox = {
        enable = true;
        profileNames = ["default"];
      };
      stylix.targets.vscode.enable = true;
    })
    
    (lib.mkIf (!hasStylix) {
      stylix.enable = false;
    })
  ];
}
