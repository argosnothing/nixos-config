
{
  inputs,
  pkgs,
  settings,
  ...
}: {
  stylix.polarity = "dark";
  stylix = {
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
      sizes = settings.fonts.sizes;
    };
  };
}
