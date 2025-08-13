{ userSettings, config, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = userSettings.font;
      font_size = config.stylix.fonts.sizes.terminal;
      disable_ligatures = "never";
    };
    extraConfig = ''
      font_features ${userSettings.font} +liga +clig +calt
    '';
  };
}
