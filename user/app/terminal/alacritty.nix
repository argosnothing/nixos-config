{ userSettings, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = config.stylix.fonts.sizes.terminal;
        normal.family = userSettings.font;
        features = ["liga=1" "clig=1" "calt=1"];
      };
    };
  };
}
