{
  pkgs,
  settings,
  ...
}: {
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code #keep
    nerd-fonts.fira-mono #keep
    nerd-fonts.liberation # keep
    nerd-fonts.noto #keep
    settings.monoFontPkgName
    settings.sansFontPkgName
    settings.serifFontPkgName
    nerd-fonts.symbols-onlyName
    font-awesome
    material-design-icons
  ];
  custom.persist.home = {
    directories = [".cache/fontconfig"];
  };
}
