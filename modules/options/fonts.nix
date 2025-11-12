{
  flake.modules.nixos.options = {
    pkgs,
    lib,
    config,
    ...
  }: let
    inherit (lib.types) int;
    inherit (lib) mkOption;
    inherit (lib.types) str package submodule;
    inherit (config.my.fonts) mono sans serif size;
  in {
    options.my.fonts = {
      size = mkOption {
        type = int;
        default = 11;
        description = "Static font size preference";
      };
      sizes = mkOption {
        default = {};
        type = submodule {
          options = {
            applications = mkOption {
              type = int;
              default = size;
            };
            terminal = mkOption {
              type = int;
              default = size;
            };
            desktop = mkOption {
              type = int;
              default = size;
            };
            popups = mkOption {
              type = int;
              default = size;
            };
          };
        };
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
        persist.home = {
          directories = [".cache/fontconfig"];
        };
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
      fonts.packages = with pkgs; [
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
  };
}
