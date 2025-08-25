{
  userSettings,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = config.stylix.fonts.sizes.terminal;
        normal.family = userSettings.monoFont;
        features = ["liga=1" "clig=1" "calt=1"];
      };
      window = {
        opacity = 0.85; # 85% opaque, adjust as desired
        # For blur, you need to enable it in your compositor (e.g., Hyprland, picom)
      };
    };
  };
}
