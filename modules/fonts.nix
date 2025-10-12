{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.types) int;
  inherit (lib) mkOption;
  inherit (lib.types) str package;
  inherit (config.my.modules.fonts) mono sans serif;
in {
  options.my.modules.fonts = {
    size = mkOption {
      type = int;
      default = 14;
      description = "Static font size preference";
    };
    mono = {
      name = mkOption {
        description = "Name of Mono Font";
        default = "FiraCode Nerd Font";
        type = str;
      };
      package = mkOption {
        description = "Package of Mono Font";
        default = pkgs.nerd-fonts.fira-code;
        type = package;
      };
    };
    sans = {
      name = mkOption {
        description = "Name of Sans Font";
        default = "Noto Sans";
        type = str;
      };
      package = mkOption {
        description = "Package of Sans Font";
        default = pkgs.noto-fonts;
        type = package;
      };
    };
    serif = {
      name = mkOption {
        description = "Name of Serif Font";
        default = "Noto Serif";
        type = str;
      };
      package = mkOption {
        description = "Package of Serif Font";
        default = pkgs.noto-fonts;
        type = package;
      };
    };
  };
  config = {
    my = {
      modules = {
        fonts = {
          serif = {
            name = "Alegreya Serif";
            package = pkgs.google-fonts;
          };
          mono = {
            name = "Cascadia Code";
            package = pkgs.cascadia-code;
          };
        };
      };
      persist.home = {
        directories = [".cache/fontconfig"];
      };
    };
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      mono.package
      sans.package
      serif.package
      nerd-fonts.noto
      nerd-fonts.symbols-only
      font-awesome
    ];
    fonts.fontconfig = {
      defaultFonts = {
        monospace = [mono.name];
        sansSerif = [sans.name];
        serif = [serif.name];
      };
    };
  };
}
