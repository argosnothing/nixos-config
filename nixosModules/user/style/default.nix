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
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
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
