## TODO: Move stylix stuff to a stylix.nix. This should simply be a file for bundling modules.
{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  inherit (config.my.modules.fonts) mono sans serif sizes;
  inherit (config.my.modules.style.theme) custom theme polarity style;
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str enum submodule nullOr;
  style-modifier =
    if style != null
    then "-${style}"
    else "";
  base16Scheme =
    if custom.enable
    then inputs.occult-theme.themes.${custom.theme}
    else "${pkgs.base16-schemes}/share/themes/${theme}${style-modifier}.yaml";
in {
  imports = [
    ./gowall.nix
    ./gtk.nix
  ];
  options = {
    my.modules.style.stylix.enable = mkEnableOption "Enable stylix";
    my.modules.style.theme = mkOption {
      default = {};
      type = submodule {
        options = {
          custom = mkOption {
            default = {};
            type = submodule {
              options = {
                enable = mkEnableOption "Enable Custom Theme";
                theme = mkOption {
                  type = enum ["occult"];
                  default = "occult";
                };
              };
            };
          };
          polarity = mkOption {
            type = enum ["light" "dark"];
            default = "dark";
          };
          theme = mkOption {
            type = str;
            default = "rose-pine";
          };
          style = mkOption {
            type = nullOr str;
            default = null;
          };
        };
      };
    };
  };
  config = mkIf config.my.modules.style.stylix.enable {
    environment.sessionVariables =
      if custom.enable
      then base16Scheme
      else {};
    stylix = {
      enable = true;
      autoEnable = true;
      targets.grub.enable = false;
      inherit polarity;
      base16Scheme = base16Scheme;
      icons = {
        enable = true;
        inherit (config.my.modules.icons) package;
      };
      fonts = {
        monospace = mono;
        sansSerif = sans;
        inherit serif;
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji-blob-bin;
        };
        inherit sizes;
      };
    };
  };
}
