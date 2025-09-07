# Tie All the hosts together
{
  inputs,
  pkgs,
  pkgsUnstable,
  system,
  ...
}: let
  desktop = import ./desktop/default.nix {inherit inputs pkgs pkgsUnstable system defaultSettings;};
  laptop = import ./laptop/default.nix {inherit inputs pkgs pkgsUnstable system defaultSettings;};
  p51 = import ./p51 {inherit inputs pkgs pkgsUnstable system defaultSettings;};
  defaultSettings = {
    username = "salivala";
    homedir = "nixos-config"; # TODO: make relative path use this
    flakedir = "~/${defaultSettings.homedir}";
    absoluteflakedir = "/home/${defaultSettings.username}/${defaultSettings.homedir}/";
    monoFont = "FiraCode Nerd Font";
    monoFontPkg = pkgs.nerd-fonts.fira-code;
    serifFont = "Liberation Serif";
    serifFontPkg = pkgs.liberation_ttf;
    sansFont = "Liberation Sans";
    sansFontPkg = pkgs.liberation_ttf;
    stylixTheme = "catppuccin-latte"; # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
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
  nixosConfigurations = desktop.nixosConfigurations // laptop.nixosConfigurations // p51.nixosConfigurations;
  homeConfigurations = desktop.homeConfigurations // laptop.homeConfigurations // p51.homeConfigurations;
}