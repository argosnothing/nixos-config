# Tie All the hosts together
{inputs, pkgs, pkgsUnstable, system, ...}: let
  desktop = import ./desktop/default.nix {inherit inputs pkgs pkgsUnstable system defaultSettings;};
  laptop = import ./laptop/default.nix {inherit inputs pkgs pkgsUnstable system defaultSettings;};
  defaultSettings = {
    username = "salivala";
    flakedir = "~/nixos-config";
    wm = "hyprland";
    monoFont = "FiraCode Nerd Font";
    monoFontPkg = pkgs.nerd-fonts.fira-code;
    serifFont = "Liberation Serif";
    serifFontPkg = pkgs.liberation_ttf;
    sansFont = "Liberation Sans";
    sansFontPkg = pkgs.liberation_ttf;
    stylixTheme = "gruvbox-dark-hard";
    battery.enable = false;
    fonts = {
      sizes = {
        applications = 12;
        terminal = 10;
        desktop = 10;
        popups = 10;
      };
    };
  };
in {
  nixosConfigurations = desktop.nixosConfigurations // laptop.nixosConfigurations;
  homeConfigurations = desktop.homeConfigurations  // laptop.homeConfigurations;
}
