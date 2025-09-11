{
  pkgs,
  config,
  lib,
  settings,
  ...
}: {
  imports = [ ../../stylix-config.nix ];
  config = lib.mkIf config.styles.stylix.enable {
    stylix.targets.grub.enable = false;
    
    stylix.polarity = settings.polarity;
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
  };

}
