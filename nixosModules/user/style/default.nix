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
      inherit (settings) polarity;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
      enable = true;
      autoEnable = true;
      targets = {
        hyprland.enable = true;
        firefox = {
          enable = true;
          profileNames = ["default"];
        };
        vscode.enable = true;
      };
      fonts = {
        monospace = {
          package = pkgs.${settings}.monoFontPkgName;
          name = settings.monoFont;
        };
        sansSerif = {
          package = pkgs.${settings}.sansFontPkgName;
          name = settings.sansFont;
        };
        serif = {
          package = pkgs.${settings}.serifFontPkg;
          name = settings.serifFont;
        };
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji-blob-bin;
        };
        inherit (settings.fonts) sizes;
      };
    };
  };
}
