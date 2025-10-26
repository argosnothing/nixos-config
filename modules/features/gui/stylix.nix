{
  flake.modules.nixos.stylix = {
    config,
    inputs,
    pkgs,
    ...
  }: let
    inherit (config.my.fonts) mono sans serif sizes;
    inherit (config.my.style) theme polarity style custom;
    style-modifier =
      if style != null
      then "-${style}"
      else "";
    base16Scheme =
      if custom.enable
      then inputs.occult-theme.themes.${custom.theme}
      else "${pkgs.base16-schemes}/share/themes/${theme}${style-modifier}.yaml";
  in {
    imports = [inputs.stylix.nixosModules.stylix];
    environment.sessionVariables =
      if custom.enable
      then base16Scheme
      else {};
    stylix = {
      enable = true;
      autoEnable = true;
      targets.grub.enable = false;
      inherit polarity;
      inherit base16Scheme;
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
