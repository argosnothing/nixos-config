{
  inputs,
  pkgs,
  settings,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
    image = pkgs.fetchurl {
      url = "https://github.com/NixOS/nixos-artwork/raw/master/wallpapers/nix-wallpaper-nineish-dark-gray.png";
      sha256 = "sha256-nhIUtCy/Hgy8P0eUssEJ0ikcOBjdAb3Uu8VqThZOWFs=";
    };
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
      sizes = {
        applications = 12;
        terminal = 8;
        desktop = 10;
        popups = 10;
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    targets = {
      grub.enable = false;
    };
  };
  environment.systemPackages = [
    inputs.swww.packages.${pkgs.system}.swww
  ];
  fonts = {
    packages = with pkgs; [
      settings.monoFontPkg
      settings.sansFontPkg 
      settings.serifFontPkg
      nerd-fonts.symbols-only
      font-awesome
      material-design-icons
    ];
    fontconfig.enable = true;
  };
}
