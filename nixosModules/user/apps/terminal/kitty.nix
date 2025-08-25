{
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      # Let Stylix handle font and colors
      disable_ligatures = "never";
      background_opacity = lib.mkForce "0.85"; # 85% opaque, same as alacritty
    };
  };
}
