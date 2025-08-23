{
  pkgs,
  inputs,
  settings,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = true;
    
    # Base16 theme - from settings, same as system
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
    
    # Font sizes - same as system
    fonts = {
      sizes = {
        applications = 12;
        terminal = 10;
        desktop = 10;
        popups = 10;
      };
    };
    
    targets = {
      firefox = {
        enable = true;
        profileNames = ["default"];
      };
    };
  };
}
