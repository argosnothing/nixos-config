{
  pkgs,
  config,
  lib,
  settings,
  ...
}: {
  options = {
    styles.stylix.enable = lib.mkEnableOption "enable stylix";
  };
  config = lib.mkIf config.styles.stylix.enable {
    stylix = {
      targets.grub.enable = false;

      inherit (settings) polarity;

      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
      fonts = {
        monospace = {
          package = settings.monoFontPkg;
          name = settings.monoFont;
        };
        sansSerif = {
          package = settings.sansFontPkg;
          name = settings.sansFont;
        };
        serif = {
          package = settings.serifFontPkg;
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
