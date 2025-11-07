{
  flake.modules.nixos.oxocarbon = {
    config,
    pkgs,
    lib,
    ...
  }: let
    inherit (config.my.theme) polarity;
    inherit (lib) mkForce;
    theme-name =
      if polarity == "dark"
      then "oxocarbon-dark"
      else "oxocarbon-light";
  in {
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme-name}.yaml";
    my = {
      theme = {
        name =
          if polarity == "dark"
          then "oxocarbon-dark"
          else "oxocarbon-light";
      };
      cursor = {
      };
    };
    hm = {
      stylix.targets = {
        vesktop.enable = mkForce true;
        vencord.enable = mkForce true;
        firefox = {
          enable = mkForce true;
          profileNames = ["default"];
          colorTheme.enable = true;
        };
      };
    };
  };
}
