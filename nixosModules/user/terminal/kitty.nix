{
  settings,
  config,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = settings.monoFont;
      #font_size = config.stylix.fonts.sizes.terminal;
      disable_ligatures = "never";
      background_opacity = lib.mkForce "0.85"; # 85% opaque, same as alacritty
    };
    extraConfig = ''
      font_features ${settings.monoFont} +liga +clig +calt
    '';
  };
}
