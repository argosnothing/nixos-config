{
  flake.modules.nixos.oxocarbon = {
    config,
    pkgs,
    lib,
    ...
  }: let
    inherit (config.my.theme) polarity;
    inherit (lib) mkForce;
    theme =
      if polarity == "dark"
      then mkForce "${oxocarbon}/base16-oxocarbon-dark.yaml"
      else mkForce "${oxocarbon}/base16-oxocarbon-light.yaml";
    oxocarbon = pkgs.fetchFromGitHub {
      owner = "nyoom-engineering";
      repo = "base16-oxocarbon";
      rev = "main";
      sha256 = "sha256-zdXNP+8ch0nXB128fNMP4h3ksH4S2HChY0vsbGhm8SY=";
    };
    colors = config.lib.stylix.colors.withHashtag;
  in {
    stylix.base16Scheme = theme;
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
    hj.files.".config/noctalia/colors.json".text = ''
      {
        "mPrimary": "${colors.base0D}",
        "mSecondary": "${colors.base0B}",
        "mTertiary": "${colors.base0E}",
        "mError": "${colors.base08}",

        "mOnPrimary": "${colors.base00}",
        "mOnSecondary": "${colors.base00}",
        "mOnTertiary": "${colors.base00}",
        "mOnError": "${colors.base00}",

        "mSurface": "${colors.base00}",
        "mOnSurface": "${colors.base05}",

        "mSurfaceVariant": "${colors.base02}",
        "mOnSurfaceVariant": "${colors.base06}",
        "mOutline": "${colors.base03}",

        "mShadow": "${colors.base00}"
      }
    '';
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
