## TODO: Move stylix stuff to a stylix.nix. This should simply be a file for bundling modules.
{
  pkgs,
  config,
  lib,
  settings,
  inputs,
  ...
}: let
  inherit (config.my.modules.fonts) mono sans serif;
  inherit (inputs.occult-theme.themes) occult;
in {
  imports = [
    ./gowall.nix
  ];
  options = {
    my.modules.style.stylix.enable = lib.mkEnableOption "enable stylix";
  };
  config = lib.mkIf config.my.modules.style.stylix.enable {
    environment.sessionVariables = occult;
    stylix = {
      enable = true;
      autoEnable = true;
      targets.grub.enable = false;
      inherit (settings) polarity;
      base16Scheme = occult;
      fonts = {
        monospace = mono;
        sansSerif = sans;
        inherit serif;
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji-blob-bin;
        };
        inherit (settings.fonts) sizes;
      };
    };
  };
}
