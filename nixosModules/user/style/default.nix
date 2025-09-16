{
  config,
  lib,
  inputs,
  ...
}: let
  hasStylix = config.styles.stylix.enable;
in {
  imports = [
    ../../stylix-config.nix
  ];
  config = lib.mkMerge [
    (lib.mkIf hasStylix {
      stylix = {
        targets = {
          hyprland.enable = true;
          firefox = {
            enable = true;
            profileNames = ["default"];
          };
          vscode.enable = true;
        };
      };
    })

    (lib.mkIf (!hasStylix) {
      stylix.enable = false;
    })
  ];
}
