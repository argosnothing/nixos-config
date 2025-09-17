{
  config,
  lib,
  ...
}: {
  options = {
    styles.stylix.enable = lib.mkEnableOption "Enable Stylix";
  };
  config = lib.mkIf config.styles.stylix.enable {
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
  };
}
