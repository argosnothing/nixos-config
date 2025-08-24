{
  pkgs,
  inputs,
  settings,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [settings.monoFont];
      sansSerif = [settings.sansFont];
      serif = [settings.serifFont];
    };
  };
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.polarity = "dark";
  stylix.targets.hyprland.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
  stylix.targets.firefox = {
    enable = true;
    profileNames = ["default"];
  };
  stylix.fonts = {
    monospace = {
      name = settings.monoFont;
      package = settings.monoFontPkg;
    };
    serif = {
      name = settings.serifFont;
      package = settings.serifFontPkg;
    };
    sansSerif = {
      name = settings.sansFont;
      package = settings.sansFontPkg;
    };
    sizes = {
      applications = 12;
      terminal = 10;
      desktop = 10;
      popups = 10;
    };
  };

  stylix.targets.gtk.enable = true;
}
