# Tie All the hosts together
{inputs, pkgs, pkgsUnstable, system, ...}: let
  desktop = import ./desktop/default.nix {inherit inputs pkgs pkgsUnstable system settings;};
  laptop = import ./laptop/default.nix {inherit inputs pkgs pkgsUnstable system settings;};
  settings = {
    username = "salivala";
    wm = "hyprland";
    monoFont = "FiraCode Nerd Font";
    monoFontPkg = pkgs.nerd-fonts.fira-code;
    serifFont = "Liberation Serif";
    serifFontPkg = pkgs.liberation_ttf;
    sansFont = "Liberation Sans";
    sansFontPkg = pkgs.liberation_ttf;
    # Stylix theme
    stylixTheme = "gruvbox-dark-hard";
  };
in {
  nixosConfigurations = desktop.nixosConfigurations // laptop.nixosConfigurations;
  homeConfigurations = desktop.homeConfigurations  // laptop.homeConfigurations;
}
