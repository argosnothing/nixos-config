{pkgs, ...}: let 
  defaultSettings = {
    username = "salivala";
    homedir = "nixos-config";
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
 in defaultSettings