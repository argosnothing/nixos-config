{
  inputs,
  pkgs,
  settings,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    # Base16 theme - from settings
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${settings.stylixTheme}.yaml";
    # Use swww for wallpaper management instead of setting a static image
    # This allows you to change wallpapers dynamically with swww
    image = pkgs.fetchurl {
      url = "https://github.com/NixOS/nixos-artwork/raw/master/wallpapers/nix-wallpaper-nineish-dark-gray.png";
      sha256 = "sha256-nhIUtCy/Hgy8P0eUssEJ0ikcOBjdAb3Uu8VqThZOWFs=";
    };
    # Fonts configuration from settings
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

    # Cursor theme
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # Target applications
    targets = {
      grub.enable = false;
    };
  };

  # Add swww and icon fonts for wallpaper management
  environment.systemPackages = [
    inputs.swww.packages.${pkgs.system}.swww
  ];

  # Ensure icon fonts are available system-wide
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
