{inputs, ...}: {
  flake.modules.nixos.options = {lib, ...}: let
    inherit (lib) mkEnableOption;
  in {
    # This is a guard in the case i remove the stylix input in the future.
    options.my = {
      stylix = {
        enable = mkEnableOption "Enable Stylix";
      };
    };
  };
  flake.modules.nixos.stylix = {
    config,
    pkgs,
    ...
  }: let
    inherit (config.my.fonts) mono sans serif sizes;
    inherit (config.my.theme) name polarity style custom;
    style-modifier =
      if style != null
      then "-${style}"
      else "";
    base16Scheme =
      if custom.enable
      then inputs.occult-theme.themes.${custom.name}
      else "${pkgs.base16-schemes}/share/themes/${name}${style-modifier}.yaml";
  in {
    imports = [inputs.stylix.nixosModules.stylix];
    environment.sessionVariables =
      if custom.enable
      then base16Scheme
      else {};
    my.stylix.enable = true;
    stylix = {
      enable = true;
      autoEnable = true;
      targets.grub.enable = false;
      inherit polarity;
      #inherit base16Scheme;
      base16Scheme = ./themes/thorn/dark-cold.yaml;
      icons = {
        enable = true;
        inherit (config.my.icons) package;
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
