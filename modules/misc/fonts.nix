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
    settings.monoFontPkg
    settings.sansFontPkg
    settings.serifFontPkg
    nerd-fonts.symbols-only
    font-awesome
    material-design-icons
  ];
  my.persist.home = {
    directories = [".cache/fontconfig"];
  };
}
