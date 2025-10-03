{
  pkgs,
  config,
  lib,
  settings,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
in {
  options = {
    my.modules.style.stylix.enable = lib.mkEnableOption "enable stylix";
  };
  config = lib.mkIf config.my.modules.style.stylix.enable {
    environment.sessionVariables = {
      BASE00 = c.base00;
      BASE01 = c.base01;
      BASE02 = c.base02;
      BASE03 = c.base03;
      BASE04 = c.base04;
      BASE05 = c.base05;
      BASE06 = c.base06;
      BASE07 = c.base07;
      BASE08 = c.base08;
      BASE09 = c.base09;
      BASE0A = c.base0A;
      BASE0B = c.base0B;
      BASE0C = c.base0C;
      BASE0D = c.base0D;
      BASE0E = c.base0E;
      BASE0F = c.base0F;
    };
    stylix = {
      enable = true;
      targets.grub.enable = false;
      inherit (settings) polarity;
      autoEnable = true;
      #base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
      base16Scheme = ./occult.yaml;
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
