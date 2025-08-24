{
  inputs,
  pkgs,
  settings,
  ...
}: {
  stylix.targets.grub.enable = false;
  stylix.homeManagerIntegration.autoImport = true;
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
      # Add icon themes for system-wide compatibility
      adwaita-icon-theme
      hicolor-icon-theme
      papirus-icon-theme
    ];
  };

  # Ensure proper GTK/icon theme environment for all applications
  environment.variables = {
    # Set fallback icon theme for applications that don't inherit from stylix
  };
}
