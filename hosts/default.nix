# Tie All the hosts together
{inputs, pkgs, ...}: let
  desktop = import ./desktop/default.nix {inherit inputs pkgs settings;};
  settings = {
    username = "salivala";
    wm = "hyprland";
    monoFont = "Fira Code";
    monoFontPkg = pkgs.fira-code;
    serifFont = "Liberation Serif";
    serifFontPkg = pkgs.liberation_ttf;
    sansFont = "Liberation Sans";
    sansFontPkg = pkgs.liberation_ttf;
  };
in {
  nixosConfigurations = desktop.nixosConfigurations; # // laptop.nixosConfigurations;
  homeConfigurations = desktop.homeConfigurations; # // laptop.homeConfigurations;
}
