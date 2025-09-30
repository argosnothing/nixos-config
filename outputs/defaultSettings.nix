{pkgs, ...}: let
  defaultSettings = rec {
    isvm = false;
    zfs = {
      hostId = "AB12CD34";
      devNodes =
        "/dev/disk/"
        + (
          if isvm
          then "by-partuuid"
          else "by-id"
        );
    };
    system = "x86_64-linux";
    with-config = name: ./. + "${absoluteflakedir}/.config/${name}";
    username = "salivala";
    gitEmail = "argosnothing@gmail.com";
    # firmware needs to be declared in the host explicitly.
    homedir = "nixos-config";
    flakedir = "~/${defaultSettings.homedir}";
    absoluteflakedir = "/home/${defaultSettings.username}/${defaultSettings.homedir}/";
    monoFont = "FiraCode Nerd Font";
    monoFontPkg = pkgs.nerd-fonts.fira-code;
    serifFont = "Liberation Serif";
    serifFontPkg = pkgs.liberation_ttf;
    sansFont = "Liberation Sans";
    sansFontPkg = pkgs.liberation_ttf;
    stylixTheme = "catppuccin-mocha"; # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
    polarity = "dark";
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
in
  defaultSettings
