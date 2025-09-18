{
  config,
  lib,
  pkgs,
  settings,
  ...
}: {
  options = {
    styles.stylix.enable = lib.mkEnableOption "Enable Stylix";
  };
  config = lib.mkIf config.styles.stylix.enable {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
      enable = true;
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
